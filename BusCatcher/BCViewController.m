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

@synthesize resultTextView=_resultTextView, getDeparturesButton=_getDeparturesButton;

BCAppLocationManager *appLocationManager;
BCBusStopSearchClient *busStopSearchClient;
BCBusStopDeparturesSearchClient *busStopDeparturesSearchClient;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    busStopSearchClient = [[BCBusStopSearchClient alloc] init];
    [busStopSearchClient setDelegate:self];

    busStopDeparturesSearchClient = [[BCBusStopDeparturesSearchClient alloc] init];
    [busStopDeparturesSearchClient setDelegate:self];
    
    appLocationManager = [[BCAppLocationManager alloc] init];
    [appLocationManager setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getNearByDepartures:(id)sender {
    // Query Location and Initiate Bus Stop lookup
    [appLocationManager queryLocation];
    [_getDeparturesButton setEnabled:NO];
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
    for (BCBusStop *busStop in busStops) {
        [busStopDeparturesSearchClient searchForDeparturesBySLSiteId:busStop andWithTimeWindow:@"30"];
    }
}

#pragma mark BCBusStopDeparturesSearchDelegate
- (void)searchForDeparturesBySLSiteIdResult:(BCBusStop *)busStop
{
    NSLog(@"%@",busStop);
    [_getDeparturesButton setEnabled:YES];
    NSString *sumOfBusStopsDescriptions = [[_resultTextView text] stringByAppendingString:[busStop description]];
    [_resultTextView setText:sumOfBusStopsDescriptions];
}

@end
