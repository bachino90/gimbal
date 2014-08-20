//
//  GBeaconView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeaconView.h"
#import "GBeacon.h"

@interface GBeaconView ()
@property (nonatomic, strong) GBeacon *beacon;
@end

#define LITTLE_CIRCLE_WIDTH 5.0f

@implementation GBeaconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithBeacon:(GBeacon *)beacon {
    self = [self initWithFrame:CGRectMake(0.0, 0.0, LITTLE_CIRCLE_WIDTH, LITTLE_CIRCLE_WIDTH)];
    if (self) {
        self.beacon = beacon;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIColor *color;
    UIColor *alphaColor;
    
    UIBezierPath *bigCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.center.x, self.center.y, self.bounds.size.width, self.bounds.size.width)];
    [alphaColor setFill];
    [bigCircle fill];
    [color setStroke];
    bigCircle.lineWidth = 2;
    [bigCircle stroke];
    
    UIBezierPath *littleCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.center.x, self.center.y, LITTLE_CIRCLE_WIDTH, LITTLE_CIRCLE_WIDTH)];
    [color setFill];
    [littleCircle fill];
    [color setStroke];
    littleCircle.lineWidth = 2;
    [littleCircle stroke];
}


@end
