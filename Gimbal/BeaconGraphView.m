//
//  BeaconGraphView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 22/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "BeaconGraphView.h"
#import "GBeacon.h"
#import "GraphView.h"
#import "GraphAxisView.h"
#import "GraphGridView.h"

@interface BeaconGraphView ()
@property (nonatomic) float *history;
@property (nonatomic) int index;
@property (nonatomic) CGFloat minimum;
@property (nonatomic) CGFloat maximum;
@property (nonatomic, strong) GraphGridView *gridView;
@property (nonatomic, strong) GraphAxisView *axisView;
@property (nonatomic, strong) GraphView *graphView;
@end

@implementation BeaconGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUpView];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUpView];
}

#define GRID_X_MARGIN 0.0

- (void)setUpView {
    //self.backgroundColor = [UIColor whiteColor];
    self.graphType = GraphTypeRSSI;
    self.gridView = [[GraphGridView alloc]initWithFrame:CGRectMake(GRID_X_MARGIN, 0.0, self.frame.size.width-GRID_X_MARGIN, self.frame.size.height)];
    [self addSubview:self.gridView];
    self.axisView = [[GraphAxisView alloc]initWithFrame:CGRectMake(0.0, 0.0, GRID_X_MARGIN, self.frame.size.height)];
    [self addSubview:self.axisView];
    self.graphView = [[GraphView alloc]initWithFrame:CGRectMake(GRID_X_MARGIN, 0.0, self.frame.size.width-GRID_X_MARGIN, self.frame.size.height)];
    [self addSubview:self.graphView];
}

- (void)setGraphType:(GraphType)graphType {
    _graphType = graphType;
    [self setNeedsDisplay];
}

- (void)setBeacon:(GBeacon *)beacon {
    self.graphView.beacon = beacon;
    /*
    _history = beacon.historyRSSI;
    self.index = beacon.index;
    self.maximum = -100;
    self.minimum = -30;
    [self setNeedsDisplay];
    */
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (_history == NULL || sizeof(_history) == 0) {
        return;
    }
    UIColor *color = [UIColor colorWithRed:(252/255.0) green:(98/255.0) blue:(35/255.0) alpha:1.0];
    UIColor *alphaColor = [UIColor colorWithRed:(252/255.0) green:(98/255.0) blue:(35/255.0) alpha:0.6];
    
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
    
    [alphaColor setFill];
    [bezierPath fill];
    [color setStroke];
    bezierPath2.lineWidth = 2;
    [bezierPath2 stroke];

}
*/

@end
