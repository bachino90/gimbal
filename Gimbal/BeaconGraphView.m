//
//  BeaconGraphView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 22/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "BeaconGraphView.h"

@implementation BeaconGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithHeight:(CGFloat)height {
    self = [self initWithFrame:CGRectMake(0.0, 0.0, 0.0, height)];
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat xWidth = width/NUMBER_OF_RECORDS;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGFloat yInit;// = _days[0]/self.maxAmmount;
    CGFloat x = 0.0;
    CGPoint initPoint = CGPointMake(x, (1-yInit)*height);
    [bezierPath moveToPoint:initPoint];
    
    
    CGPoint prevPoint = initPoint;
    for (int i=1; i<=1; i++) {
        x += xWidth;
        CGFloat y;// = _days[i]/self.maxAmmount;
        
        CGPoint point = CGPointMake(x,(1-y)*height);
        CGPoint leftPoint = CGPointMake(prevPoint.x+xWidth*0.55, prevPoint.y);
        CGPoint rightPoint = CGPointMake(point.x-xWidth*0.55, point.y);
        
        [bezierPath addCurveToPoint:point controlPoint1:leftPoint controlPoint2:rightPoint];
        prevPoint = point;
    }
    [bezierPath addLineToPoint:CGPointMake(x, self.frame.size.height)];
    [bezierPath addLineToPoint:CGPointMake(0.0, self.frame.size.height)];
    [bezierPath addLineToPoint:CGPointMake(0.0, (1-yInit)*height)];
    [bezierPath closePath];
    
    UIColor *color = [UIColor blueColor];
    [color setFill];
    [bezierPath fill];
}

@end
