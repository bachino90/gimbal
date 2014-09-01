//
//  GimbalAppDelegate.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 26/07/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GimbalAppDelegate.h"
#import <FYX/FYX.h>
#import <ContextCore/QLContextCoreConnector.h>
#import <ContextLocation/QLPlaceEvent.h>
#import <ContextLocation/QLPlace.h>


@implementation GimbalAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    QLContextCoreConnector *connector = [QLContextCoreConnector new];
    [connector enableFromViewController:self.window.rootViewController success:^
     {
         NSLog(@"Gimbal enabled");
     } failure:^(NSError *error) {
         NSLog(@"Failed to initialize gimbal %@", error);
     }];
    
    [FYX setAppId:@"601fe9d96f86be4d49cf2f8e4fdb50b7018dc1c74ce4032ba8260d8cf8b1c0a4" appSecret:@"b20a5f785b517e9cfe5a82f82a7cf1d2bd12d36d039f664c76568dcf2e134c93" callbackUrl:@"combaxlabsgimbal://authcode"];
    
    //self.placeConnector = [[QLContextPlaceConnector alloc] init];
    //self.placeConnector.delegate = self;
    [[UILabel appearance]setTintColor:[UIColor fontColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *navColor = [UIColor navBarColor];
    CGContextSetFillColorWithColor(context, [navColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor orangeColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           nil]];
    /*
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    */
    return YES;
}

- (void)didGetPlaceEvent:(QLPlaceEvent *)placeEvent
{
    NSLog(@"did get place event %@", [placeEvent place].name);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
