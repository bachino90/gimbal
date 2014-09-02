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
        self.color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35];
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    float height = self.frame.size.height;
    float width = self.frame.size.width;
    int numberOfGaps = floorf(height/self.deltaLine);
    float heightOfGaps = numberOfGaps * self.deltaLine;
    float margin = (height-heightOfGaps)/2.0f;
    
    float y = margin;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    //CGContextSetLineWidth(context,1);
    
    CGFloat dotRadius = 1.0;
    CGFloat lengths[2];
    lengths[0] = 0;
    lengths[1] = dotRadius * 2;
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, dotRadius);
    CGContextSetLineDash(context, 0.0f, lengths, 2);

    CGContextBeginPath(context);
    for (int i=0; i<=numberOfGaps; i++) {
        CGContextMoveToPoint(context,0.0,y);
        CGContextAddLineToPoint(context,width+2.0,y);
        y+=self.deltaLine;
    }
    CGContextClosePath(context);
    CGContextStrokePath(context);
}


@end
