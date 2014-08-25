//
//  GraphGridView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 25/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GraphGridView.h"

@interface GraphGridView ()
@property (nonatomic) CGFloat deltaLine;
@end

@implementation GraphGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        if (frame.size.height < 100.0f) {
            self.deltaLine = 30.0f;
        } else {
            self.deltaLine = 60.0f;
        }
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIColor *grayColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:0.95];
    float height = self.frame.size.height;
    float width = self.frame.size.width;
    int numberOfGaps = floorf(height/self.deltaLine);
    float heightOfGaps = numberOfGaps * self.deltaLine;
    float margin = (height-heightOfGaps)/2.0f;
    
    float y = margin;
    CGPoint initPoint = CGPointMake(0.0, y);
    CGPoint finishPoint = CGPointMake(width, y);
    for (int i=0; i<=numberOfGaps; i++) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:initPoint];
        [bezierPath addLineToPoint:finishPoint];
        [grayColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
        y+=self.deltaLine;
        initPoint.y = y;
        finishPoint.y = y;
    }
}


@end
