//
//  GBeaconViewController.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 20/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBeacon;

@interface GBeaconViewController : UIViewController
@property (nonatomic, weak) GBeacon *beacon;
@end
