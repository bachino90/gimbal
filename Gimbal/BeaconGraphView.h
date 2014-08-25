//
//  BeaconGraphView.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 22/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBeacon;

typedef NS_ENUM(NSInteger, GraphType) {
    GraphTypeRSSI,
    GraphTypeDistance,
    GraphTypeTemperature
};

@interface BeaconGraphView : UIView

@property (nonatomic, weak) GBeacon *beacon;
@property (nonatomic) GraphType graphType;

@end
