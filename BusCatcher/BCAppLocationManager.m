//
//  BCAppLocationManager.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCAppLocationManager.h"

@implementation BCAppLocationManager

@synthesize delegate=_delegate;

CLLocationManager *locationManager;

- (id)init
{
    if (self = [super init]) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager setDelegate:self];
    }
    return self;
}

- (void)queryLocation
{
    [locationManager startUpdatingLocation];
}

# pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [locationManager stopUpdatingLocation];
    if ( [_delegate respondsToSelector:@selector(queryLocationComplete:)] ) {
        [_delegate queryLocationComplete:newLocation.coordinate];
    } else {
        NSLog(@"%@ Does not repond to selector queryLocationComplete",[_delegate class]);
    }
}

@end