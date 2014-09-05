//
//  MeView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "MeView.h"

@implementation MeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = [UIColor roomViewMeColor];
    }
    return self;
}

@end
