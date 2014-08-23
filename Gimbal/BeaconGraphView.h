//
//  BeaconGraphView.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 22/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBeacon;

@interface BeaconGraphView : UIView

@property (nonatomic, weak) GBeacon *beacon;

- (instancetype)initWithHeight:(CGFloat)height;

@end
