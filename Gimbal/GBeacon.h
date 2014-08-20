//
//  GBeacon.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>

@interface GBeacon : NSObject

@property (nonatomic, readonly) CGPoint location;
@property (nonatomic, readonly) CGFloat lastRSSI;
@property (nonatomic, readonly) CGFloat timeToLastUpdate;
@property (nonatomic, readonly) NSDate *startTime;

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *UUID;
@property (nonatomic, readonly) NSString *majorID;
@property (nonatomic, readonly) NSString *minorID;
@property (nonatomic, readonly) NSString *store;
@property (nonatomic, readonly) NSString *area;

- (instancetype)initWithVisit:(FYXVisit *)visit;
- (void)updateRSSI:(NSNumber *)rssi;

@end
