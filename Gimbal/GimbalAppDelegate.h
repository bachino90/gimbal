//
//  GimbalAppDelegate.h
//  Gimbal
//
//  Created by Emiliano Bivachi on 26/07/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContextLocation/QLContextPlaceConnector.h>

@interface GimbalAppDelegate : UIResponder <UIApplicationDelegate, QLContextPlaceConnectorDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) QLContextPlaceConnector *placeConnector;

@end
