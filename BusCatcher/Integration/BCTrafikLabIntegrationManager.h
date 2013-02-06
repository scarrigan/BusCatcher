//
//  BCTrafikLabIntegrationManager.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/26/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BCBusStopSearchClient.h"
#import "BCBusStopDeparturesSearchClient.h"

@protocol BCTrafikLabIntegrationDelegate <NSObject>
- (void)departuresFromBusStop:(BCBusStop *)busStop;
- (void)busStopsFromLocation:(NSArray *)busStops;
@end

@interface BCTrafikLabIntegrationManager : NSObject <BCBusStopSearchDelegate,BCBusStopDeparturesSearchDelegate> 

@property (strong,nonatomic) id delegate;

- (void) getDeparturesFromBusStop:(BCBusStop *)busStop;
- (void) getBusStopsFromLocation:(CLLocationCoordinate2D)coordinate2D andWithinRadius:(NSString *) radius;

@end
