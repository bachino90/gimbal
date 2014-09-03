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
    return [UIColor colorWithRed:(59/255.0) green:(59/255.0) blue:(71/255.0) alpha:1.0]; //95,95,114
}

+ (UIColor *)backgroundColor {
    return [UIColor colorWithRed:(45/255.0) green:(45/255.0) blue:(57/255.0) alpha:1.0];
}

+ (UIColor *)tableViewBackgroundColor {
    return [UIColor colorWithRed:(45/255.0) green:(45/255.0) blue:(57/255.0) alpha:1.0];
}

+ (UIColor *)tableViewCellBackgroundColor {
    return [UIColor colorWithRed:(70/255.0) green:(70/255.0) blue:(84/255.0) alpha:1.0];
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
    color.red = 95/255.0;//241/255.0;
    color.green = 95/255.0;//59/255.0;
    color.blue = 114/255.0;//94/255.0;
    color.alpha = 1.0;
    return color;//[UIColor blueColor];
}

+ (RGBAColor)roomViewMeColor {
    RGBAColor color;
    color.red = 100/255.0;
    color.green = 120/255.0;
    color.blue = 230/255.0;
    color.alpha = 1.0;
    return color;//[UIColor redColor];
}

#pragma mark GraphView colors

+ (UIColor *)backgroundColorForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed:(44/255.0) green:(218/255.0) blue:(172/255.0) alpha:1.0];
            break;
        case GraphTypeDistance:
            color = [UIColor colorWithRed:(248/255.0) green:(129/255.0) blue:(127/255.0) alpha:1.0];
            break;
        case GraphTypeTemperature:
            color = [UIColor colorWithRed:(240/255.0) green:(175/255.0) blue:(101/255.0) alpha:1.0];
            break;
        default:
            color = [UIColor colorWithRed:(44/255.0) green:(218/255.0) blue:(172/255.0) alpha:1.0];
            break;
    }
    return color;
}

+ (UIColor *)gridColorForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.25];
            break;
        case GraphTypeDistance:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.25];
            break;
        case GraphTypeTemperature:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.25];
            break;
        default:
            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.25];
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
            color = [UIColor colorWithRed:(44/255.0) green:(218/255.0) blue:(172/255.0) alpha:1.0];//[UIColor colorWithRed:(31/255.0) green:(169/255.0) blue:(171/255.0) alpha:1.0];
            break;
        case GraphTypeDistance:
            color = [UIColor colorWithRed:(248/255.0) green:(129/255.0) blue:(127/255.0) alpha:1.0];
            break;
        case GraphTypeTemperature:
            color = [UIColor colorWithRed:(240/255.0) green:(175/255.0) blue:(101/255.0) alpha:1.0];
            break;
        default:
            color = [UIColor colorWithRed:(44/255.0) green:(218/255.0) blue:(172/255.0) alpha:1.0];
            break;
    }
    return color;
}

+ (UIColor *)gradientColor1ForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed:(44/255.0) green:(218/255.0) blue:(172/255.0) alpha:0.4];
            break;
        case GraphTypeDistance:
            color = [UIColor colorWithRed:(248/255.0) green:(129/255.0) blue:(127/255.0) alpha:0.4];
            break;
        case GraphTypeTemperature:
            color = [UIColor colorWithRed:(240/255.0) green:(175/255.0) blue:(101/255.0) alpha:0.4];
            break;
        default:
            color = [UIColor colorWithRed:(44/255.0) green:(218/255.0) blue:(172/255.0) alpha:0.4];
            break;
    }
    return color;
}

+ (UIColor *)gradientColor2ForType:(GraphType)type {
    UIColor *color;
    switch (type) {
        case GraphTypeRSSI:
            color = [UIColor colorWithRed:(44/255.0) green:(218/255.0) blue:(172/255.0) alpha:0.2];
            break;
        case GraphTypeDistance:
            color = [UIColor colorWithRed:(248/255.0) green:(129/255.0) blue:(127/255.0) alpha:0.2];
            break;
        case GraphTypeTemperature:
            color = [UIColor colorWithRed:(240/255.0) green:(175/255.0) blue:(101/255.0) alpha:0.2];
            break;
        default:
            color = [UIColor colorWithRed:(44/255.0) green:(218/255.0) blue:(172/255.0) alpha:0.2];
            break;
    }
    return color;
}


@end
