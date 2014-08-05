//
//  AppDelegate.m
//  HelloBeacon
//
//  Created by Yannick Weiss on 05/08/14.
//  Copyright (c) 2014 Yannick Weiss. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
  CLLocationManager *locationManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [self startMonitoringItem];
  
  return YES;
}

- (void)startMonitoringItem {
  NSString *proximityUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
  NSUUID *leUUID = [[NSUUID alloc] initWithUUIDString:proximityUUID];
  
  CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:leUUID identifier:@"com.yannickweiss"];
  locationManager = [[CLLocationManager alloc] init];
  locationManager.delegate = self;
  [locationManager startMonitoringForRegion:beaconRegion];
  [locationManager startRangingBeaconsInRegion:beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  NSLog(@"entered");
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
  NSLog(@"exited");
}


- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
