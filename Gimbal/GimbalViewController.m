//
//  GimbalViewController.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 26/07/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GimbalViewController.h"
#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>
#import <FYX/FYXiBeacon.h>

@interface GimbalViewController () <FYXServiceDelegate,FYXVisitDelegate,FYXiBeaconVisitDelegate>
@property (weak, nonatomic) IBOutlet UILabel *rssi_one;
@property (weak, nonatomic) IBOutlet UILabel *rssi_two;
@property (weak, nonatomic) IBOutlet UILabel *rssi_three;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (nonatomic) FYXVisitManager *visitManager;

@property (nonatomic, strong) NSNumber *last_rssi_one;
@property (nonatomic, strong) NSNumber *last_rssi_two;
@property (nonatomic, strong) NSNumber *last_rssi_three;

@end

#define RSSI_IN_ONE_METER 77.0f

@implementation GimbalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.rssi_one.text = @"";
    self.rssi_two.text = @"";
    self.rssi_three.text = @"";
    self.position.text = @"";
    
    [FYX startService:self];
    self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
    self.visitManager.iBeaconDelegate = self;
    [self.visitManager start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)serviceStarted
{
    // this will be invoked if the service has successfully started
    // bluetooth scanning will be started at this point.
    NSLog(@"FYX Service Successfully Started");
}

- (void)startServiceFailed:(NSError *)error
{
    // this will be called if the service has failed to start
    NSLog(@"%@", error);
}

- (void)didArrive:(FYXVisit *)visit
{
    // this will be invoked when an authorized transmitter is sighted for the first time
    NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
}

- (void)calculatePosition {
    if (self.last_rssi_one && self.last_rssi_two && self.last_rssi_three) {
        float one_meters = [self.last_rssi_one integerValue];
        float two_meters = [self.last_rssi_two integerValue];
        float three_meters = [self.last_rssi_three integerValue];
        
        //float one_x = 0;
        //float one_y = 0;
        float two_x = 1.8;
        //float two_y = 0.0;
        float three_x = 1.2;
        float three_y = 2.04;
        
        float x = ((one_meters*one_meters) - (two_meters*two_meters) + (two_x*two_x))/(4*(two_x*two_meters));
        float y = (((one_meters*one_meters) - (three_meters*three_meters) + (three_x*three_x) + (three_y*three_y))/(2*three_y)) - ((three_x/three_y)*x);
        float z = sqrt((one_meters*one_meters)-(x*x)-(y*y));
        self.position.text = [NSString stringWithFormat:@"X: %.2f Y: %.2f Z: %.2f",x,y,z];
    }
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI
{
    // this will be invoked when an authorized transmitter is sighted during an on-going visit
    NSLog(@"I received a sighting!!! %@, RSSI: %@", visit.transmitter.name, RSSI);
    
    float num = ((-[RSSI floatValue] - 77.0)/(10.0*2.5));
    float distance = pow(10,num);
    if ([visit.transmitter.name isEqual:@"My Third Beacon"]) {
        self.last_rssi_three = @(distance);
        self.rssi_three.text = [NSString stringWithFormat:@"%@ | %.2fm",RSSI,distance];
    } else if ([visit.transmitter.name isEqual:@"My Second Beacon"]) {
        self.last_rssi_two = @(distance);
        self.rssi_two.text = [NSString stringWithFormat:@"%@ | %.2fm",RSSI,distance];
    } else if ([visit.transmitter.name isEqual:@"My First Beacon"]) {
        self.last_rssi_one = @(distance);
        self.rssi_one.text = [NSString stringWithFormat:@"%@ | %.2fm",RSSI,distance];
    }
    
    [self calculatePosition];
}

- (void)didDepart:(FYXVisit *)visit
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}

- (void)didArriveIBeacon:(FYXiBeaconVisit *)visit
{
    // this will be invoked when a managed Gimbal beacon is sighted for the first time
    NSLog(@"I arrived within the proximity of a Gimbal beacon!!! Proximity UUID:%@ Major:%@ Minor:%@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor);
}

- (void)receivedIBeaconSighting:(FYXiBeaconVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI
{
    // this will be invoked when a managed Gimbal beacon is sighted during an on-going visit
    NSLog(@"I received a sighting!!! Proximity UUID:%@ Major:%@ Minor:%@ RSSI:%@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor, RSSI);
}

- (void)didDepartIBeacon:(FYXiBeaconVisit *)visit
{
    // this will be invoked when a managed Gimbal beacon has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal beacon!!!! Proximity UUID:%@ Major:%@ Minor:%@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}

@end
