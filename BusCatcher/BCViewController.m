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
BCTrafikLabIntegrationManager *integrationManager;

UIActivityIndicatorView *indicator;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    appLocationManager = [[BCAppLocationManager alloc] init];
    [appLocationManager setDelegate:self];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = _resultTextView.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    
    integrationManager = [[BCTrafikLabIntegrationManager alloc] init];
    [integrationManager setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getNearByDepartures:(id)sender {

    [indicator startAnimating];
    
    // Query Location and Initiate Bus Stop lookup
    [_resultTextView setText:@""];
    [appLocationManager queryLocation];
}

#pragma mark BCAppLocationManagerDelegate
- (void)queryLocationComplete:(CLLocationCoordinate2D)locationCoordinate2D
{
    [integrationManager getDeparturesFromLocation:locationCoordinate2D andWithinRadius:@"500"];
}

#pragma mark BCTrafikLabIngegrationDelegate
- (void)departuresFromLocation:(BCBusStop *)busStop {
    NSLog(@"%@",[busStop description]);

    NSString *sumOfBusStopsDescriptions = [[_resultTextView text] stringByAppendingString:[busStop description]];
    [_resultTextView setText:sumOfBusStopsDescriptions];

    [indicator stopAnimating];

}

@end
