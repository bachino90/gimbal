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
    }
    return self;
}

- (void)setDeltaLine:(CGFloat)deltaLine {
    _deltaLine = deltaLine;
    self.numberOfLines = 1+floorf(self.frame.size.height/deltaLine);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}



@end
