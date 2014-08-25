//
//  GBeaconView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeaconView.h"
#import "RoomView.h"
#import "GBeacon.h"

@interface GBeaconView ()
@end

#define LITTLE_CIRCLE_WIDTH 5.0f

@implementation GBeaconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"updateIndex"]) {
        CGFloat distance = 2 * ((GBeacon *)object).lastDistance;
        CGFloat scale = ((RoomView *)self.superview).scale;
        CGPoint lastCenter = self.center;
        distance *= scale;
        if (distance < LITTLE_CIRCLE_WIDTH+2) {
            distance = LITTLE_CIRCLE_WIDTH+2;
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x, distance, distance);
        self.center = lastCenter;
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIColor *color = [UIColor blueColor];
    UIColor *alphaColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.4];
    
    CGFloat centerX = (self.frame.size.width / 2.0) - (self.frame.size.width/2.0);
    CGFloat centerY = centerX;
    
    UIBezierPath *bigCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1.0, 1.0, self.frame.size.width-2.0, self.frame.size.width-2.0)];
    [alphaColor setFill];
    [bigCircle fill];
    [color setStroke];
    bigCircle.lineWidth = 2;
    [bigCircle stroke];
    
    centerX = (self.frame.size.width / 2.0) - (LITTLE_CIRCLE_WIDTH/2.0);
    centerY = centerX;
    
    UIBezierPath *littleCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerX, centerY, LITTLE_CIRCLE_WIDTH, LITTLE_CIRCLE_WIDTH)];
    [color setFill];
    [littleCircle fill];
    [color setStroke];
    littleCircle.lineWidth = 2;
    [littleCircle stroke];
}


@end
