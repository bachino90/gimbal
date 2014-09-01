//
//  GraphAxisView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 25/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GraphAxisView.h"

@interface GraphAxisView ()
@property (nonatomic) CGFloat deltaLine;
@property (nonatomic) int numberOfLines;
@end

@implementation GraphAxisView

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
        self.color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    }
    return self;
}

/*
- (void)setDeltaLine:(CGFloat)deltaLine {
    _deltaLine = deltaLine;
    self.numberOfLines = 1+floorf(self.frame.size.height/deltaLine);
}
*/
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
    
    
    //CGSize size = CGSizeMake(rect.size.width, rect.size.height);
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:7];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw stroke
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    
    float rectHeight = 10.0;
    float y = margin - rectHeight - 1.0;
    CGRect rect2 = CGRectMake(3.0, y, width, rectHeight);
    for (int i=0; i<=numberOfGaps; i++) {
        
        rect2 = CGRectMake(3.0, y, width, 10.0);
        [@"100" drawInRect:CGRectIntegral(rect2) withAttributes:@{NSFontAttributeName: font}];
        
        y+=self.deltaLine;
    }
}

@end
