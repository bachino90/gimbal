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
    self.gridView = [[GraphGridView alloc]initWithFrame:CGRectMake(GRID_X_MARGIN, 0.0, self.frame.size.width-GRID_X_MARGIN, self.frame.size.height)];
    self.axisView = [[GraphAxisView alloc]initWithFrame:CGRectMake(0.0, 0.0, 20.0, self.frame.size.height)];
    self.graphView = [[GraphView alloc]initWithFrame:CGRectMake(GRID_X_MARGIN, 0.0, self.frame.size.width-GRID_X_MARGIN, self.frame.size.height)];
    self.graphType = GraphTypeRSSI;
    [self addSubview:self.gridView];
    [self addSubview:self.axisView];
    [self addSubview:self.graphView];
}

- (void)setGraphType:(GraphType)graphType {
    _graphType = graphType;
    self.backgroundColor = [UIColor backgroundColorForType:graphType]; //[UIColor orangeColor];
    self.gridView.color = [UIColor gridColorForType:graphType];
    self.axisView.color = [UIColor axisColorForType:graphType];
    self.graphView.strokeColor = [UIColor strokeColorForType:graphType];
    self.graphView.gradientColor1 = [UIColor gradientColor1ForType:graphType];
    self.graphView.gradientColor2 = [UIColor gradientColor2ForType:graphType];
}

- (void)setBeacon:(GBeacon *)beacon {
    self.graphView.beacon = beacon;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
