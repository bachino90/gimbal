//
//  GBeaconViewController.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 20/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeaconViewController.h"
#import "GBeacon.h"
#import "BeaconGraphView.h"

@interface GBeaconViewController ()
@property (nonatomic, weak) IBOutlet BeaconGraphView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UIView *rssiView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;
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
    self.view.backgroundColor = [UIColor navBarColor];//[UIColor colorWithRed:(253/255.0) green:(146/255.0) blue:(39/255.0) alpha:1.0];
    
    self.graphView.clearBackground = NO;
    self.graphView.graphType = GraphTypeRSSI;
    //self.graphView.beacon = self.beacon;
    
    self.rssiLabel.text = [NSString stringWithFormat:@"%i",self.beacon.lastRSSI];
    self.rssiView.backgroundColor = [UIColor backgroundColorForType:GraphTypeRSSI];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f",self.beacon.lastDistance];
    self.distanceView.backgroundColor = [UIColor backgroundColorForType:GraphTypeDistance];
    
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
        //[self.visibleCells removeObject:[self.tableView indexPathForCell:cell]];
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
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"updateIndex"]) {
        self.beacon = (GBeacon *)object;
        //[self setUpView];
    }
}

- (IBAction)rssiButtonTapped:(UIButton *)sender {
    if (self.graphView.graphType != GraphTypeRSSI) {
        self.graphView.graphType = GraphTypeRSSI;
    }
}

- (IBAction)distanceButtonTapped:(UIButton *)sender {
    if (self.graphView.graphType != GraphTypeDistance) {
        self.graphView.graphType = GraphTypeDistance;
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
