//
//  GBeaconManager.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GBeaconManager;

@protocol GBeaconManagerDelegate <NSObject>
@end

@interface GBeaconManager : NSObject

@property (nonatomic, weak) id <GBeaconManagerDelegate> delegate;
@property (nonatomic, strong, readonly) NSMutableDictionary *beacons;

+ (instancetype)sharedManager;
- (void)startScanning;

@end
