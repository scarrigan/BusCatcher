//
//  BCBusStationSearchClient.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BCBusStop.h"

@protocol BCBusStopSearchDelegate <NSObject>
- (void)searchByCoordinateResult:(NSArray *)busStops;
- (void)searchSLBusStopByNameResult:(NSArray *)busStops;
@end

@interface BCBusStopSearchClient : NSObject

@property (nonatomic,weak) id<BCBusStopSearchDelegate> delegate;

- (void)searchByCoordinate:(CLLocationCoordinate2D)coordinate2D andWithinRange:(NSString *)rangeInMeters;
- (void)searchForSLBusStopByName:(BCBusStop *)busStop;

@end
