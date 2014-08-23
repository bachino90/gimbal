//
//  BeaconGraphView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 22/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "BeaconGraphView.h"
#import "GBeacon.h"

@interface BeaconGraphView ()
@property (nonatomic) float *history;
@property (nonatomic) int index;
@property (nonatomic) CGFloat minimum;
@property (nonatomic) CGFloat maximum;
@end

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

- (void)setBeacon:(GBeacon *)beacon {
    _history = beacon.historyRSSI;
    self.index = beacon.index;
    self.maximum = -100;
    self.minimum = -30;
    [self setNeedsDisplay];
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
    CGFloat yInit = (_history[self.index]-self.minimum) * (1/(self.maximum-self.minimum));// entre 0 y 1
    if (yInit > 1) {
        yInit = 1;
    } else if (yInit < 0) {
        yInit = 0;
    }
    CGFloat x = 0.0;
    CGPoint initPoint = CGPointMake(x, (1-yInit)*height);
    [bezierPath moveToPoint:initPoint];
    
    CGPoint prevPoint = initPoint;
    int index = self.index;
    for (int i=index; i>=0; i--) {
        x += xWidth;
        CGFloat y = (_history[self.index]-self.minimum) * (1/(self.maximum-self.minimum));
        if (y > 1) {
            y = 1;
        } else if (y < 0) {
            y = 0;
        }
        CGPoint point = CGPointMake(x,(1-y)*height);
        CGPoint leftPoint = CGPointMake(prevPoint.x+xWidth*0.55, prevPoint.y);
        CGPoint rightPoint = CGPointMake(point.x-xWidth*0.55, point.y);
        
        [bezierPath addCurveToPoint:point controlPoint1:leftPoint controlPoint2:rightPoint];
        prevPoint = point;
    }
    int lenght = NUMBER_OF_RECORDS - 1;
    for (int i=lenght; i>index; i--) {
        x += xWidth;
        CGFloat y = (_history[self.index]-self.minimum) * (1/(self.maximum-self.minimum));
        if (y > 1) {
            y = 1;
        } else if (y < 0) {
            y = 0;
        }
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
