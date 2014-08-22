//
//  GBeacon.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeacon.h"

@interface GBeacon ()
//PRIVATE PROPERTIES
@property (nonatomic) NSUInteger index;
@property (nonatomic) int *historyRSSI;
@property (nonatomic) int *filteredRSSI;
@property (nonatomic) double *historyDistance;

@property (nonatomic, strong) NSMutableArray *history;
@property (nonatomic, strong) NSMutableArray *filtered;

//PUBLIC PROPERTIES
@property (nonatomic, readwrite) CGPoint location;
@property (nonatomic, readwrite) NSInteger lastRSSI;
@property (nonatomic, readwrite) CGFloat lastDistance;
@property (nonatomic, readwrite) CGFloat timeToLastUpdate;
@property (nonatomic, readwrite) NSDate *startTime;

@property (nonatomic, readwrite) NSString *identifier;
@property (nonatomic, readwrite) NSString *UUID;
@property (nonatomic, readwrite) NSString *majorID;
@property (nonatomic, readwrite) NSString *minorID;
@property (nonatomic, readwrite) NSString *store;
@property (nonatomic, readwrite) NSString *area;

@end    

@implementation GBeacon

- (instancetype)init {
    self = [super init];
    if (self) {
        self.index = NUMBER_OF_RECORDS-1;
        self.historyRSSI = (int*) calloc (NUMBER_OF_RECORDS,sizeof(int));
        self.filteredRSSI = (int*) calloc (NUMBER_OF_RECORDS,sizeof(int));
        self.historyDistance = (double*) calloc (NUMBER_OF_RECORDS,sizeof(double));
        self.updateIndex = 0;
        self.lastRSSI = 0;
        self.lastDistance = 0;
    }
    return self;
}

- (void)dealloc {
    free(self.historyRSSI);
    free(self.filteredRSSI);
    free(self.historyDistance);
}

- (instancetype)initWithVisit:(FYXVisit *)visit {
    self = [self init];
    if (self) {
        self.startTime = visit.startTime;
        self.identifier = visit.transmitter.identifier;
        if ([visit.transmitter.name isEqual:@"My First Beacon"]) {
            self.location = CGPointMake(1.0, 0.5);
        } else if ([visit.transmitter.name isEqual:@"My Second Beacon"]) {
            self.location = CGPointMake(1.0, 1.5);
        } else if ([visit.transmitter.name isEqual:@"My Third Beacon"]) {
            self.location = CGPointMake(2.0, 0.5);
        }
    }
    return self;
}

- (void)updateRSSI:(NSNumber *)rssi {
    self.historyRSSI[self.index] = [rssi intValue];
    self.filteredRSSI[self.index] = [rssi intValue];
    self.lastRSSI = self.filteredRSSI[self.index];
    
    double num = ((-[rssi doubleValue] + RSSI_ONE_METER)/(10.0*2.5));
    double distance = pow(10,num);
    self.historyDistance[self.index] = distance;
    self.lastDistance = self.historyDistance[self.index];
    
    self.updateIndex++;
    if (self.index > 0) {
        self.index--;
    } else {
        self.index = NUMBER_OF_RECORDS-1;
    }
}

@end
