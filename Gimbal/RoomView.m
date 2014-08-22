//
//  RoomView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "RoomView.h"
#import "GBeaconView.h"
#import "MeView.h"
#import "GBeacon.h"

@interface RoomView ()
@property (nonatomic, strong) NSMutableDictionary *beaconsViews;
@property (nonatomic, strong) MeView *meView;
@property (nonatomic, readwrite) CGFloat scale;
@end

@implementation RoomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.beaconsViews = [NSMutableDictionary dictionary];
        self.scale = 100.0f;
    }
    return self;
}

- (void)addBeacon:(GBeacon *)beacon {
    GBeaconView *beaconView = [[GBeaconView alloc]initWithBeacon:beacon];
    [beacon addObserver:beaconView forKeyPath:KVO_KEY_PATH options:NSKeyValueObservingOptionNew context:NULL];
    beaconView.center = CGPointMake(self.scale * beacon.location.x, self.scale * beacon.location.y);
    [self addSubview:beaconView];
    [self.beaconsViews setObject:beaconView forKey:beacon.identifier];
}

- (void)removeBeacon:(GBeacon *)beacon {
    GBeaconView *beaconView = self.beaconsViews[beacon.identifier];
    [beacon removeObserver:beaconView forKeyPath:KVO_KEY_PATH];
    [beaconView removeFromSuperview];
    [self.beaconsViews removeObjectForKey:beacon.identifier];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
