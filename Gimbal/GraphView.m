//
//  GraphView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 25/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GraphView.h"
#import "GBeacon.h"

@interface GraphView ()
@property (nonatomic) float *history;
@property (nonatomic) int index;
@property (nonatomic) CGFloat minimum;
@property (nonatomic) CGFloat maximum;
@end

@implementation GraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
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
    if (_history == NULL || sizeof(_history) == 0) {
        return;
    }
    //UIColor *strokeColor = [UIColor colorWithRed:(252/255.0) green:(98/255.0) blue:(35/255.0) alpha:1.0];
    //UIColor *alphaColor = [UIColor colorWithRed:(252/255.0) green:(98/255.0) blue:(35/255.0) alpha:0.6];
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* colorStroke = [UIColor colorWithRed: 0.956 green: 0.743 blue: 0.396 alpha: 1];
    UIColor* gradientColor = [UIColor colorWithRed: 0.956 green: 0.743 blue: 0.396 alpha: 0.45];//[UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.95];
    UIColor* gradientColor2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.04];
    
    //// Gradient Declarations
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)gradientColor.CGColor, (id)gradientColor2.CGColor], gradientLocations);
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat xWidth = width/NUMBER_OF_RECORDS;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
    CGFloat yInit = (_history[self.index]-self.minimum) * (1/(self.maximum-self.minimum));// entre 0 y 1
    if (yInit > 1) {
        yInit = 1;
    } else if (yInit < 0) {
        yInit = 0;
    }
    CGFloat x = 0.0;
    CGPoint initPoint = CGPointMake(x, (1-yInit)*height);
    [bezierPath moveToPoint:initPoint];
    [bezierPath2 moveToPoint:initPoint];
    
    //CGPoint prevPoint = initPoint;
    int index = self.index;
    for (int i=index; i>=0; i--) {
        x += xWidth;
        CGFloat y = (_history[i]-self.minimum) * (1/(self.maximum-self.minimum));
        if (y > 1) {
            y = 1;
        } else if (y < 0) {
            y = 0;
        }
        CGPoint point = CGPointMake(x,(1-y)*height);
        [bezierPath addLineToPoint:point];
        [bezierPath2 addLineToPoint:point];
    }
    int lenght = NUMBER_OF_RECORDS - 1;
    for (int i=lenght; i>index; i--) {
        x += xWidth;
        CGFloat y = (_history[i]-self.minimum) * (1/(self.maximum-self.minimum));
        if (y > 1) {
            y = 1;
        } else if (y < 0) {
            y = 0;
        }
        CGPoint point = CGPointMake(x,(1-y)*height);
        [bezierPath addLineToPoint:point];
        [bezierPath2 addLineToPoint:point];
    }
    [bezierPath addLineToPoint:CGPointMake(x, self.frame.size.height)];
    [bezierPath addLineToPoint:CGPointMake(0.0, self.frame.size.height)];
    [bezierPath addLineToPoint:CGPointMake(0.0, (1-yInit)*height)];
    [bezierPath closePath];
    
    [colorStroke setStroke];
    bezierPath2.lineWidth = 2;
    [bezierPath2 stroke];
    
    CGContextSaveGState(context);
    [bezierPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(self.frame.size.width/2, 0), CGPointMake(self.frame.size.width/2, self.frame.size.height), 0);
    CGContextRestoreGState(context);
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
