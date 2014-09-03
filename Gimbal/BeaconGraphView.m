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
    self.clearBackground = YES;
    self.backgroundColor = [UIColor clearColor];
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
    if (!self.clearBackground) {
        self.backgroundColor = [UIColor backgroundColorForType:graphType];
    }
    self.gridView.color = [UIColor gridColorForType:graphType];
    self.axisView.color = [UIColor axisColorForType:graphType];
    self.graphView.strokeColor = [UIColor strokeColorForType:graphType];
    self.graphView.gradientColor1 = [UIColor gradientColor1ForType:graphType];
    self.graphView.gradientColor2 = [UIColor gradientColor2ForType:graphType];
    switch (self.graphType) {
        case GraphTypeRSSI:
            self.graphView.maximum = -100;
            self.graphView.minimum = -30;
            break;
        case GraphTypeDistance:
            self.graphView.maximum = 20;
            self.graphView.minimum = 0;
            break;
        case GraphTypeTemperature:
            self.graphView.maximum = 60;
            self.graphView.minimum = -5;
            break;
        default:
            self.graphView.maximum = -100;
            self.graphView.minimum = -30;
            break;
    }
    self.beacon = self.beacon;
}

- (void)setBeacon:(GBeacon *)beacon {
    _beacon = beacon;
    if (beacon) {
        self.graphView.index = beacon.index;
        switch (self.graphType) {
            case GraphTypeRSSI:
                self.graphView.history = beacon.filteredRSSI;
                break;
            case GraphTypeDistance:
                self.graphView.history = beacon.historyDistance;
                break;
            case GraphTypeTemperature:
                self.graphView.history = beacon.filteredRSSI;
                break;
            default:
                self.graphView.history = beacon.filteredRSSI;
                break;
        }

    }
}

@end
