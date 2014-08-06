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
}

@end

@implementation ViewController
- (IBAction)start:(id)sender {
  [self startMonitoringItem];
}

- (void)startMonitoringItem {
  NSString *proximityUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
  NSUUID *leUUID = [[NSUUID alloc] initWithUUIDString:proximityUUID];
  
  CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:leUUID identifier:@"region1"];
  locationManager = [[CLLocationManager alloc] init];
  locationManager.delegate = self;
  [locationManager requestAlwaysAuthorization];
  beaconRegion.notifyEntryStateOnDisplay = YES;
  [locationManager startMonitoringForRegion:beaconRegion];
  [locationManager startRangingBeaconsInRegion:beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  NSLog(@"entered");
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.29.101.25:3000/hi/yannick"]];
  NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
  NSLog(@"exited");
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.29.101.25:3000/bye/yannick"]];
  NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
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
