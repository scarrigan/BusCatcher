//
//  BCTrafikLabIntegrationManager.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/26/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCTrafikLabIntegrationManager.h"
#import "BCBusStop.h"

@implementation BCTrafikLabIntegrationManager

@synthesize delegate=_delegate;

BCBusStopSearchClient *busStopSearchClient;
BCBusStopDeparturesSearchClient *busStopDeparturesSearchClient;

- (id)init {
    if((self = [super init])) {
        busStopSearchClient = [[BCBusStopSearchClient alloc] init];
        [busStopSearchClient setDelegate:self];
        
        busStopDeparturesSearchClient = [[BCBusStopDeparturesSearchClient alloc] init];
        [busStopDeparturesSearchClient setDelegate:self];
    }
    return self;
}

- (void) getBusStopsFromLocation:(CLLocationCoordinate2D)coordinate2D andWithinRadius:(NSString *) radius {
    [busStopSearchClient searchByCoordinate:coordinate2D andWithinRange:radius];
}

- (void) getDeparturesFromBusStop:(BCBusStop *)busStop {
    [busStopDeparturesSearchClient searchForDeparturesBySLSiteId:busStop andWithTimeWindow:@"30"];
}

#pragma mark BCBusStopSearchDelegate
- (void)searchByCoordinateResult:(NSArray *)busStops
{
    for (BCBusStop *busStop in busStops){
        [busStopSearchClient searchForSLBusStopByName:busStop];
    }
}

- (void)searchSLBusStopByNameResult:(NSArray *)busStops
{
    if ( [_delegate respondsToSelector:@selector(busStopsFromLocation:)] ) {
        [_delegate busStopsFromLocation:busStops];
    } else {
        NSLog(@"%@ Does not repond to selector busStopsFromLocation",[_delegate class]);
    }
}

#pragma mark BCBusStopDeparturesSearchDelegate
- (void)searchForDeparturesBySLSiteIdResult:(BCBusStop *)busStop
{
    if ([[busStop departures] count] > 0) {
        if ( [_delegate respondsToSelector:@selector(departuresFromBusStop:)] ) {
            [_delegate departuresFromBusStop:busStop];
        } else {
            NSLog(@"%@ Does not repond to selector departuresFromBusStop",[_delegate class]);
        }
    }
}

@end
