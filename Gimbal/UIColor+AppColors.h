//
//  UIColor+AppColors.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 01/09/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

struct RGBAColor {
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
};
typedef struct RGBAColor RGBAColor;

typedef NS_ENUM(NSInteger, GraphType) {
    GraphTypeRSSI,
    GraphTypeDistance,
    GraphTypeTemperature
};

@interface UIColor (AppColors)

// UI colors
+ (UIColor *)navBarColor;
+ (UIColor *)backgroundColor;
+ (UIColor *)tableViewBackgroundColor;
+ (UIColor *)tableViewCellBackgroundColor;
+ (UIColor *)scrollViewBackgroundColor;
+ (UIColor *)fontColor;
// RoomView colors
+ (RGBAColor)roomViewBackgroundColor;
+ (RGBAColor)roomViewScaleLineColor;
+ (RGBAColor)roomViewBeaconColor;
+ (RGBAColor)roomViewMeColor;

// Graph View colors
+ (UIColor *)backgroundColorForType:(GraphType)type;
+ (UIColor *)gridColorForType:(GraphType)type;
+ (UIColor *)axisColorForType:(GraphType)type;
+ (UIColor *)strokeColorForType:(GraphType)type;
+ (UIColor *)gradientColor1ForType:(GraphType)type;
+ (UIColor *)gradientColor2ForType:(GraphType)type;

@end
