//
//  GBeaconViewController.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 20/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeaconViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GBeacon.h"
#import "BeaconGraphView.h"
#import "GEditBeaconViewController.h"

@interface GBeaconViewController () <BackHomeProtocol>
@property (nonatomic, weak) IBOutlet BeaconGraphView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UIView *rssiView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorIdLabel;

//Constant Labels
@property (weak, nonatomic) IBOutlet UILabel *dbLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiConstantLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceConstantLabel;
@end

@implementation GBeaconViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Set the background and shadow image to get rid of the line.
    [self setUpView];
    
}

- (void)setUpView {
    self.view.backgroundColor = [UIColor navBarColor];
    self.mLabel.font = [UIFont appFontWithSize:12.0];
    self.dbLabel.font = [UIFont appFontWithSize:12.0];
    self.storeTitleLabel.font = [UIFont appFontWithSize:13.0];
    //self.storeTitleLabel.textColor = [UIColor backgroundColor];
    self.areaTitleLabel.font = [UIFont appFontWithSize:13.0];
    //self.areaTitleLabel.textColor = [UIColor backgroundColor];
    self.rssiConstantLabel.font = [UIFont appFontWithSize:14.0];
    self.rssiConstantLabel.textColor = [UIColor backgroundColorForType:GraphTypeRSSI];
    
    self.distanceConstantLabel.font = [UIFont appFontWithSize:14.0];
    self.distanceConstantLabel.textColor = [UIColor backgroundColorForType:GraphTypeDistance];
    
    self.uuidLabel.font = [UIFont appFontWithSize:15.0];
    //self.uuidLabel.textColor = [UIColor backgroundColor];
    self.storeLabel.font = [UIFont appFontWithSize:20.0];
    //self.storeLabel.textColor = [UIColor backgroundColor];
    self.areaLabel.font = [UIFont appFontWithSize:20.0];
    //self.areaLabel.textColor = [UIColor backgroundColor];
    self.majorIdLabel.font = [UIFont appFontWithSize:20.0];
    //self.majorIdLabel.textColor = [UIColor backgroundColor];
    self.minorIdLabel.font = [UIFont appFontWithSize:20.0];
    //self.minorIdLabel.textColor = [UIColor backgroundColor];
    
    self.graphView.clearBackground = YES;
    self.graphView.graphType = GraphTypeRSSI;
    
    self.rssiLabel.font = [UIFont appFontWithSize:31.0];
    
    self.rssiView.backgroundColor = [UIColor backgroundColorForType:GraphTypeRSSI];
    self.rssiView.layer.cornerRadius = self.rssiView.bounds.size.width/2;
    self.rssiView.layer.borderWidth = 2.0;
    self.rssiView.layer.borderColor = [UIColor backgroundColorForType:GraphTypeRSSI].CGColor;
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f",self.beacon.lastDistance];
    self.distanceLabel.font = [UIFont appFontWithSize:31.0];
    
    //self.distanceView.backgroundColor = [UIColor backgroundColorForType:GraphTypeDistance];
    self.distanceView.layer.cornerRadius = self.distanceView.bounds.size.width/2;
    self.distanceView.layer.borderWidth = 2.0;
    self.distanceView.layer.borderColor = [UIColor backgroundColorForType:GraphTypeDistance].CGColor;
    
    
    self.uuidLabel.text = [NSString stringWithFormat:@"%@",self.beacon.identifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.beacon addObserver:self forKeyPath:KVO_KEY_PATH options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    @try {
        [self.beacon removeObserver:self forKeyPath:KVO_KEY_PATH];
    }
    @catch (NSException * __unused exception) {
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBeacon:(GBeacon *)beacon {
    _beacon = beacon;
    self.graphView.beacon = self.beacon;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f",beacon.lastDistance];
    self.rssiLabel.text = [NSString stringWithFormat:@"%li",(long)self.beacon.lastRSSI];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"updateIndex"]) {
        self.beacon = (GBeacon *)object;
    }
}

- (IBAction)rssiButtonTapped:(UIButton *)sender {
    [self selectGraphType:GraphTypeRSSI];
}

- (IBAction)distanceButtonTapped:(UIButton *)sender {
    [self selectGraphType:GraphTypeDistance];
}

- (void)selectGraphType:(GraphType)type {
    if (self.graphView.graphType != type) {
        self.graphView.graphType = type;
        [self selectButtonForType:type];
    }
}

- (void)selectButtonForType:(GraphType)type {
    switch (type) {
        case GraphTypeRSSI:
            self.rssiView.backgroundColor = [UIColor backgroundColorForType:GraphTypeRSSI];
            self.distanceView.backgroundColor = [UIColor clearColor];
            break;
        case GraphTypeDistance:
            self.rssiView.backgroundColor = [UIColor clearColor];
            self.distanceView.backgroundColor = [UIColor backgroundColorForType:GraphTypeDistance];
            break;
        default:
            break;
    }
}

#pragma mark - BackHomeProtocol

- (void)backHomeFrom:(UIViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"EditBeaconSegue"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        GEditBeaconViewController *vc = (GEditBeaconViewController *)nc.topViewController;
        vc.delegate = self;
        vc.beacon = self.beacon;
    }
}


@end
