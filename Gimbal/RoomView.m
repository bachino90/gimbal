//
//  RoomView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "RoomView.h"
#import "GridView.h"
#import "GBeaconView.h"
#import "MeView.h"
#import "GBeacon.h"

@interface RoomView ()
@property (nonatomic, strong) NSMutableDictionary *beaconsViews;
@property (nonatomic, strong) GridView *gridView;
@property (nonatomic, strong) MeView *meView;
@property (nonatomic, readwrite) CGFloat scale;
@property (nonatomic) CGFloat zoomScale;
@end

@implementation RoomView

#define DEFAULT_SCALE 100.0f

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.beaconsViews = [NSMutableDictionary dictionary];
        self.scale = DEFAULT_SCALE;
        self.gridView = [[GridView alloc]initWithFrame:self.frame];
        self.gridView.scale = self.scale;
        [self addSubview:self.gridView];
    }
    return self;
}

- (void)setZoomScale:(CGFloat)zoomScale {
    _zoomScale = zoomScale;
    
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
}

- (void)scaleView:(CGFloat)scale {
    self.zoomScale = scale;
    self.scale = _zoomScale * DEFAULT_SCALE;
    
    self.gridView.frame = CGRectMake(self.gridView.frame.origin.x, self.gridView.frame.origin.y, self.gridView.frame.size.width*self.scale, self.gridView.frame.size.height*self.scale);
    self.gridView.scale = self.scale;
    [self setNeedsDisplay];
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

- (void)addObservers {
    for (NSString *key in self.beaconsViews) {
        GBeaconView *beaconView = (GBeaconView *)self.beaconsViews[key];
        GBeacon *beacon = beaconView.beacon;
        [beacon addObserver:beaconView forKeyPath:KVO_KEY_PATH options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)removeObservers {
    for (NSString *key in self.beaconsViews) {
        GBeaconView *beaconView = (GBeaconView *)self.beaconsViews[key];
        GBeacon *beacon = beaconView.beacon;
        [beacon removeObserver:beaconView forKeyPath:KVO_KEY_PATH];
    }
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
