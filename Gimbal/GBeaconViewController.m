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

@interface GBeaconViewController ()
@property (nonatomic, weak) IBOutlet BeaconGraphView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UIView *rssiView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;
//Constant Labels
@property (weak, nonatomic) IBOutlet UILabel *dbLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;
@property (weak, nonatomic) IBOutlet UILabel *clientTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaTitleLabel;
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
    self.mLabel.font = [UIFont appFontWithSize:11.0];
    self.dbLabel.font = [UIFont appFontWithSize:11.0];
    self.clientTitleLabel.font = [UIFont appFontWithSize:11.0];
    self.storeTitleLabel.font = [UIFont appFontWithSize:11.0];
    self.areaTitleLabel.font = [UIFont appFontWithSize:11.0];
    self.uuidLabel.font = [UIFont appFontWithSize:15.0];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
