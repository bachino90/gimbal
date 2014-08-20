//
//  GBeaconManager.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeaconManager.h"
#import "GBeacon.h"
#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>
#import <FYX/FYXiBeacon.h>


@interface GBeaconManager () <FYXServiceDelegate, FYXVisitDelegate, FYXiBeaconVisitDelegate>
@property (nonatomic) FYXVisitManager *visitManager;
@property (nonatomic, strong, readwrite) NSMutableDictionary *beacons;
@property (nonatomic, strong) NSArray *beaconsID;
@end

@implementation GBeaconManager

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.beacons = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)startScanning {
    [FYX startService:self];
    self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
    self.visitManager.iBeaconDelegate = self;
    [self.visitManager start];
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
    
    //agregar beacon
    if ([self.beacons objectForKey:visit.transmitter.identifier]==nil) {
        GBeacon *newBeacon = [[GBeacon alloc]initWithVisit:visit];
        [self.beacons setObject:newBeacon forKey:visit.transmitter.identifier];
        //encontrar la posicion del beacon
    }
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI
{
    // this will be invoked when an authorized transmitter is sighted during an on-going visit
    NSLog(@"I received a sighting!!! %@, RSSI: %@", visit.transmitter.name, RSSI);
    
    GBeacon *beacon = [self.beacons objectForKey:visit.transmitter.identifier];
    if (beacon) {
        [beacon updateRSSI:RSSI];
    }
}

- (void)didDepart:(FYXVisit *)visit
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
    
    //borrar beacon
    if ([self.beacons objectForKey:visit.transmitter.identifier]) {
        [self.beacons removeObjectForKey:visit.transmitter.identifier];
    }

}


@end
