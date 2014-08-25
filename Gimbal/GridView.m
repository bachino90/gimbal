//
//  GridView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 25/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)setScale:(CGFloat)scale {
    _scale = scale;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    float scale = self.scale;
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    float max = MAX(width, height);
    int numberOfRules = floorf(max/scale) + 1;
    UIColor *grayColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:0.95];//[UIColor lightGrayColor];
    
    float delta = 0;
    
    CGPoint xInitPoint = CGPointMake(delta, 0.0);
    CGPoint xFinishPoint = CGPointMake(delta, height);
    CGPoint yInitPoint = CGPointMake(0.0, delta);
    CGPoint yFinishPoint = CGPointMake(width, delta);
    
    for (int i=0; i<=numberOfRules; i++) {
        xInitPoint.x = delta;
        xFinishPoint.x = delta;
        UIBezierPath *bezierPath1 = UIBezierPath.bezierPath;
        [bezierPath1 moveToPoint: xInitPoint];
        [bezierPath1 addLineToPoint: xFinishPoint];
        [grayColor setStroke];
        bezierPath1.lineWidth = 1;
        [bezierPath1 stroke];

        yInitPoint.y = delta;
        yFinishPoint.y = delta;
        UIBezierPath *bezierPath2 = UIBezierPath.bezierPath;
        [bezierPath2 moveToPoint: yInitPoint];
        [bezierPath2 addLineToPoint: yFinishPoint];
        [grayColor setStroke];
        bezierPath2.lineWidth = 1;
        [bezierPath2 stroke];
        
        delta += scale;
    }
}


@end
