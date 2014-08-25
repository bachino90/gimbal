//
//  GBeaconTableViewCell.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 09/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeaconTableViewCell.h"
#import "BeaconGraphView.h"

@interface GBeaconTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *rssiLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet BeaconGraphView *graphView;

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
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
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
