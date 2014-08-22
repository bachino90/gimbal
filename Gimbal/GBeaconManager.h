//
//  GBeaconManager.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GBeaconManager;
@class GBeacon;

@protocol GBeaconManagerDelegate <NSObject>
- (void)beaconManager:(GBeaconManager *)beaconManager hasFoundBeacon:(GBeacon *)beacon;
- (void)beaconManager:(GBeaconManager *)beaconManager hasLostBeacon:(GBeacon *)beacon;
- (void)beaconManager:(GBeaconManager *)beaconManager removeKVOFromIndex:(NSInteger)index;
@end

@interface GBeaconManager : NSObject

@property (nonatomic, weak) id <GBeaconManagerDelegate> delegate;
@property (nonatomic, strong, readonly) NSMutableDictionary *beacons;

+ (instancetype)sharedManager;
- (void)startScanning;
- (GBeacon *)beaconAtIndex:(NSInteger)index;

@end
