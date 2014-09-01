//
//  UIColor+AppColors.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 01/09/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "UIColor+AppColors.h"

@implementation UIColor (AppColors)


#define ORANGE [UIColor orangeColor]

#pragma mark UI colors

+ (UIColor *)navBarColor {
    return ORANGE;
}

+ (UIColor *)backgroundColor {
    return [UIColor colorWithRed:(253/255.0) green:(126/255.0) blue:(37/255.0) alpha:1.0];
}

+ (UIColor *)tableViewBackgroundColor {
    return [UIColor colorWithRed:(253/255.0) green:(143/255.0) blue:(31/255.0) alpha:1.0];
}

+ (UIColor *)tableViewCellBackgroundColor {
    return [UIColor colorWithRed:(253/255.0) green:(126/255.0) blue:(37/255.0) alpha:1.0];
}

+ (UIColor *)scrollViewBackgroundColor {
    return [UIColor colorWithRed:(255/255.0) green:(237/255.0) blue:(226/255.0) alpha:1.0];
}

+ (UIColor *)fontColor {
    return [UIColor whiteColor];
}

#pragma mark RoomView colors

+ (RGBAColor)roomViewBackgroundColor {
    RGBAColor color;
    color.red = (255/255.0);
    color.green = (237/255.0);
    color.blue = (226/255.0);
    color.alpha = 1.0;
    return color;//[UIColor colorWithRed:(255/255.0) green:(237/255.0) blue:(226/255.0) alpha:1.0];
}

+ (RGBAColor)roomViewScaleLineColor {
    RGBAColor color;
    color.red = 0.8;
    color.green = 0.8;
    color.blue = 0.8;
    color.alpha = 0.8;
    return color;//[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8];
}

+ (RGBAColor)roomViewBeaconColor {
    RGBAColor color;
    color.red = 0.0;
    color.green = 0.0;
    color.blue = 1.0;
    color.alpha = 1.0;
    return color;//[UIColor blueColor];
}

+ (RGBAColor)roomViewMeColor {
    RGBAColor color;
    color.red = 1.0;
    color.green = 0.0;
    color.blue = 0.0;
    color.alpha = 1.0;
    return color;//[UIColor redColor];
}

#pragma mark GraphView colors

+ (UIColor *)backgroundColorForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed:(253/255.0) green:(126/255.0) blue:(37/255.0) alpha:1.0];
            break;
        case GraphTypeDistance:
            
            break;
        case GraphTypeTemperature:
            
            break;
        default:
            color = [UIColor colorWithRed:(253/255.0) green:(126/255.0) blue:(37/255.0) alpha:1.0];
            break;
    }
    return color;
}

+ (UIColor *)gridColorForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            break;
        case GraphTypeDistance:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            break;
        case GraphTypeTemperature:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            break;
        default:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            break;
    }
    return color;
}

+ (UIColor *)axisColorForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            break;
        case GraphTypeDistance:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            break;
        case GraphTypeTemperature:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            break;
        default:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            break;
    }
    return color;
}

+ (UIColor *)strokeColorForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed: 0.956 green: 0.743 blue: 0.396 alpha: 1];
            break;
        case GraphTypeDistance:
            
            break;
        case GraphTypeTemperature:
            
            break;
        default:
            color = [UIColor colorWithRed: 0.956 green: 0.743 blue: 0.396 alpha: 1];
            break;
    }
    return color;
}

+ (UIColor *)gradientColor1ForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed: 0.956 green: 0.743 blue: 0.396 alpha: 0.45];
            break;
        case GraphTypeDistance:
            
            break;
        case GraphTypeTemperature:
            
            break;
        default:
            color = [UIColor colorWithRed: 0.956 green: 0.743 blue: 0.396 alpha: 0.45];
            break;
    }
    return color;
}

+ (UIColor *)gradientColor2ForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.04];
            break;
        case GraphTypeDistance:
            color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.04];
            break;
        case GraphTypeTemperature:
            color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.04];
            break;
        default:
            color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.04];
            break;
    }
    return color;
}


@end
