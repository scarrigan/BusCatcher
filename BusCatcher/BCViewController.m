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

UIActivityIndicatorView *indicator;


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
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = _getDeparturesButton.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getNearByDepartures:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
    // Query Location and Initiate Bus Stop lookup
    [_getDeparturesButton setEnabled:NO];
    [_resultTextView setText:@""];
    [appLocationManager queryLocation];
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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    [indicator stopAnimating];
}

@end
