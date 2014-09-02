//
//  GBeaconTableViewCell.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 09/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeaconTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "BeaconGraphView.h"

@interface GBeaconTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *rssiLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet BeaconGraphView *graphView;
@property (nonatomic, weak) IBOutlet UIButton *rssiButton;
@property (nonatomic, weak) IBOutlet UIButton *distanceButton;

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger rssi;
@property (nonatomic) CGFloat distance;
@property (nonatomic) int *history;
@end

@implementation GBeaconTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setUpView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self setUpView];
}

- (void)setUpView {
    self.backgroundColor = [UIColor tableViewCellBackgroundColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds] ;
    self.selectedBackgroundView.backgroundColor = [UIColor tableViewBackgroundColor];
    self.rssiLabel.backgroundColor = [UIColor strokeColorForType:GraphTypeRSSI];
    self.rssiLabel.layer.cornerRadius = 3;
    self.rssiLabel.layer.masksToBounds = YES;
    self.distanceLabel.backgroundColor = [UIColor strokeColorForType:GraphTypeDistance];
    self.distanceLabel.layer.cornerRadius = 3;
    self.distanceLabel.layer.masksToBounds = YES;
    
    self.graphView.clearBackground = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"updateIndex"]) {
        self.beacon = (GBeacon *)object;
    }
}

- (IBAction)rssiButtonTaped:(UIButton *)sender {
    if (self.graphView.graphType != GraphTypeRSSI) {
        self.graphView.graphType = GraphTypeRSSI;
    }
}


- (IBAction)distanceButtonTapped:(UIButton *)sender {
    if (self.graphView.graphType != GraphTypeDistance) {
        self.graphView.graphType = GraphTypeDistance;
    }
}

#pragma mark Properties

- (void)setBeacon:(GBeacon *)beacon {
    _beacon = beacon;
    self.name = beacon.identifier;
    self.rssi = beacon.lastRSSI;
    self.distance = beacon.lastDistance;
    self.graphView.beacon = beacon;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = name;
}

- (void)setRssi:(NSInteger)rssi {
    _rssi = rssi;
    self.rssiLabel.text = [NSString stringWithFormat:@"%lddBm",(long)rssi];
}

- (void)setDistance:(CGFloat)distance {
    _distance = distance;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2fm",distance];
}

- (void)setHistory:(int *)history {
    _history = history;
}

@end
