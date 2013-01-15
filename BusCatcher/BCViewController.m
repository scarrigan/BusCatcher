//
//  BCViewController.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCViewController.h"
#import "BCBusStop.h"
#import "BCApiKeyManager.h"

@interface BCViewController ()

@end

@implementation BCViewController

BCAppLocationManager *appLocationManager;
BCBusStopSearchClient *busStopSearchClient;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    busStopSearchClient = [[BCBusStopSearchClient alloc] init];
    [busStopSearchClient setDelegate:self];
    
    appLocationManager = [[BCAppLocationManager alloc] init];
    [appLocationManager setDelegate:self];
    
    // Query Location and Initiate Bus Stop lookup
    [appLocationManager queryLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark BCAppLocationManagerDelegate
- (void)queryLocationComplete:(CLLocationCoordinate2D)locationCoordinate2D
{
    [busStopSearchClient searchByCoordinate:locationCoordinate2D andWithinRange:@"500"];
}

#pragma mark BCBusStopSearchDelegate
- (void)searchByCoordinateResult:(NSArray *)busStops
{
    NSLog(@"%@",busStops);
    for (BCBusStop *busStop in busStops){
        [busStopSearchClient searchForSLBusStopByName:busStop];
    }
}

- (void)searchSLBusStopByNameResult:(NSArray *)busStops
{
    NSLog(@"%@",busStops);    
}

@end
