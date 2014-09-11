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
@property (nonatomic) NSMutableArray *history;
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
        [self setMaximum:MAX_RSSI andMinimum:MIN_RSSI];
    }
    return self;
}

#define RECT_HEIGHT 10.0f

- (void)setMaximum:(CGFloat)max andMinimum:(CGFloat)min {
    float height = self.frame.size.height;
    int numberOfGaps = floorf(height/self.deltaLine);
    float heightOfGaps = numberOfGaps * self.deltaLine;
    float margin = (height-heightOfGaps)/2.0f;
    
    //CGFloat y = (_history[i]-self.minimum) * (1/(self.maximum-self.minimum));
    float y = margin;
    
    self.history = [NSMutableArray array];
    for (int i=0; i<=numberOfGaps; i++) {
        CGFloat num = ((1-y/height)  * (max-min)) + min;
        NSString *str = [NSString stringWithFormat:@"%.0f",num];
        self.history[i] = str;
        y+=self.deltaLine;
    }
    
    [self setNeedsDisplay];
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
    
    UIFont *font = [UIFont appFontWithSize:10.0];
    float y = margin - RECT_HEIGHT - 2.0;
    //y+=self.deltaLine;
    CGRect rect2; //= CGRectMake(3.0, y, width, RECT_HEIGHT);
    for (int i=0; i<=numberOfGaps; i++) {
        
        rect2 = CGRectMake(3.0, y, width, RECT_HEIGHT);
        [self.history[i] drawInRect:CGRectIntegral(rect2) withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: self.color}];
        
        y+=self.deltaLine;
    }
}

@end
