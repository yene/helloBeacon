//
//  ViewController.m
//  HelloBeacon
//
//  Created by Yannick Weiss on 05/08/14.
//  Copyright (c) 2014 Yannick Weiss. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
  CLLocationManager *locationManager;
  CLBeaconRegion *beaconRegion;
}

@end

@implementation ViewController
- (IBAction)start:(id)sender {
  
  if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusAvailable) {
    
    NSLog(@"Background updates are available for the app.");
  }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied)
  {
    NSLog(@"The user explicitly disabled background behavior for this app or for the whole system.");
  }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted)
  {
    NSLog(@"Background updates are unavailable and the user cannot enable them again. For example, this status can occur when parental controls are in effect for the current user.");
  }
  
  NSLog(@"%@", [CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]] ? @"yes" : @"no");
  [self startMonitoringItem];
}

- (void)startMonitoringItem {
  locationManager = [[CLLocationManager alloc] init];
  locationManager.delegate = self;
  [locationManager requestAlwaysAuthorization];
  
  NSString *proximityUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
  NSUUID *leUUID = [[NSUUID alloc] initWithUUIDString:proximityUUID];
  
  beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:leUUID identifier:@"region1"];
  beaconRegion.notifyEntryStateOnDisplay = YES;
  [locationManager startMonitoringForRegion:beaconRegion];
  [locationManager startRangingBeaconsInRegion:beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
  if(state == CLRegionStateInside) {
    NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://chobit.local:3000/hi/yannick"]];
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  }
  else if(state == CLRegionStateOutside) {
    NSLog(@"locationManager didDetermineState OUTSIDE for %@", region.identifier);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://chobit.local:3000/bye/yannick"]];
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  }
  else {
    NSLog(@"locationManager didDetermineState OTHER for %@", region.identifier);
  }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  NSLog(@"entered");
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://chobit.local:3000/hi/yannick"]];
  NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
  NSLog(@"exited");
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://chobit.local:3000/bye/yannick"]];
  NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  
  if (![CLLocationManager locationServicesEnabled]) {
    NSLog(@"Couldnt turn on ranging: Location service are not enabled");
  }
  
  if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
    NSLog(@"Couldnt turn on ranging: Location service not authorised");
  }
  
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
  NSLog(@"monitoring did fail with error %@", [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
  // I commented out the line below because otherwise you see this every second in the logs
   //NSLog(@"locationManager didRangeBeacons");
}
            
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
