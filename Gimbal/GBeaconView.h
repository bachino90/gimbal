//
//  GBeaconView.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBeacon;

@interface GBeaconView : UIView

@property (nonatomic, strong) GBeacon *beacon;

- (instancetype)initWithBeacon:(GBeacon *)beacon;

@end
