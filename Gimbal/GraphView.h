//
//  GraphView.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 25/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBeacon;

@interface GraphView : UIView

//@property (nonatomic) GBeacon *beacon;
@property (nonatomic) CGFloat minimum;
@property (nonatomic) CGFloat maximum;
@property (nonatomic) float *history;
@property (nonatomic) int index;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic) UIColor *gradientColor1;
@property (nonatomic) UIColor *gradientColor2;

@end
