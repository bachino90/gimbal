//
//  RSSIGraphView.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 09/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBeacon;

@interface RSSIGraphView : UIView

- (instancetype)initWithBeacon:(GBeacon *)beacon;

@end
