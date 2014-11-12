//
//  GEditBeaconViewController.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 12/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackHomeProtocol.h"
#import "GBeacon.h"

@interface GEditBeaconViewController : UIViewController
@property (nonatomic, weak) id <BackHomeProtocol> delegate;
@property (nonatomic, strong) GBeacon *beacon;
@end
