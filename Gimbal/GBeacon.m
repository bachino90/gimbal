//
//  GBeacon.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeacon.h"

@interface GBeacon ()
@property (nonatomic) double *historyRSSI;
@property (nonatomic) double *filteredRSSI;

@property (nonatomic, strong) NSMutableArray *history;
@property (nonatomic, strong) NSMutableArray *filtered;
@end    

@implementation GBeacon

- (instancetype)initWithVisit:(FYXVisit *)visit {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)updateRSSI:(NSNumber *)rssi {
    int n = sizeof(self.historyRSSI) / sizeof(double);
    self.historyRSSI[n] = [rssi doubleValue];
}

@end
