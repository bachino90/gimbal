//
//  RoomView.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBeacon;

@interface RoomView : UIView

@property (nonatomic) CGFloat zoomScale;
@property (nonatomic, readonly) CGFloat scale;

- (void)addBeacon:(GBeacon *)beacon;
- (void)removeBeacon:(GBeacon *)beacon;
- (void)acomodateBeacons;

- (void)addObservers;
- (void)removeObservers;

@end
