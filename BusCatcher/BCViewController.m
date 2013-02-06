//
//  BCViewController.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCViewController.h"

@implementation BCViewController

@synthesize resultTextView=_resultTextView;

BCAppLocationManager *appLocationManager;
BCTrafikLabIntegrationManager *integrationManager;
UIActivityIndicatorView *indicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = _resultTextView.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    
    appLocationManager = [[BCAppLocationManager alloc] init];
    [appLocationManager setDelegate:self];
    
    integrationManager = [[BCTrafikLabIntegrationManager alloc] init];
    [integrationManager setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNearByDepartures
{
    [_resultTextView setText:@""];
    [indicator startAnimating];
    
    // Query Location and Initiate Bus Stop lookup
    [appLocationManager queryLocation];
}

#pragma mark BCAppLocationManagerDelegate
- (void)queryLocationComplete:(CLLocationCoordinate2D)locationCoordinate2D
{
    [integrationManager getBusStopsFromLocation:locationCoordinate2D andWithinRadius:@"500"];
}

#pragma mark BCTrafikLabIngegrationDelegate
- (void)busStopsFromLocation:(NSArray *)busStops {
    for (BCBusStop * busStop in busStops) {
        [integrationManager getDeparturesFromBusStop:busStop];
    }
}

- (void)departuresFromBusStop:(BCBusStop *)busStop {
    NSLog(@"%@",[busStop description]);
    
    NSString *sumOfBusStopsDescriptions = [[_resultTextView text] stringByAppendingString:[busStop description]];
    [_resultTextView setText:sumOfBusStopsDescriptions];
    
    [indicator stopAnimating];
}

@end
