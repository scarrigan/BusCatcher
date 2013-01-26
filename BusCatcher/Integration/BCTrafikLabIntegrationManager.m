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

- (void) getDeparturesFromLocation:(CLLocationCoordinate2D) coordinate2D andWithinRadius:(NSString *) radius {
    
    [busStopSearchClient searchByCoordinate:coordinate2D andWithinRange:radius];
    
}

- (id)init {
    if((self = [super init])) {
        busStopSearchClient = [[BCBusStopSearchClient alloc] init];
        [busStopSearchClient setDelegate:self];
        
        busStopDeparturesSearchClient = [[BCBusStopDeparturesSearchClient alloc] init];
        [busStopDeparturesSearchClient setDelegate:self];
    }
    return self;
}

#pragma mark BCBusStopSearchDelegate
- (void)searchByCoordinateResult:(NSArray *)busStops
{
    //NSLog(@"%@",busStops);
    for (BCBusStop *busStop in busStops){
        [busStopSearchClient searchForSLBusStopByName:busStop];
    }
}

- (void)searchSLBusStopByNameResult:(NSArray *)busStops
{
    //NSLog(@"%@",busStops);
    for (BCBusStop *busStop in busStops) {
        [busStopDeparturesSearchClient searchForDeparturesBySLSiteId:busStop andWithTimeWindow:@"30"];
    }
}

#pragma mark BCBusStopDeparturesSearchDelegate
- (void)searchForDeparturesBySLSiteIdResult:(BCBusStop *)busStop
{
    //NSLog(@"%@",busStop);
    if ([[busStop departures] count] > 0) {
        if ( [_delegate respondsToSelector:@selector(departuresFromLocation:)] ) {
            [_delegate departuresFromLocation:busStop];
        }
    }
}

@end
