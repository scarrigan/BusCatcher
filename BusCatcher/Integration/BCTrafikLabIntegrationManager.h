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

@protocol BCTrafikLabIngegrationDelegate <NSObject>
- (void)departuresFromLocation:(BCBusStop *)busStop;
@end

@interface BCTrafikLabIntegrationManager : NSObject <BCBusStopSearchDelegate,BCBusStopDeparturesSearchDelegate> 

@property (strong,nonatomic) id delegate;

- (void) getDeparturesFromLocation:(CLLocationCoordinate2D)coordinate2D andWithinRadius:(NSString *) radius;

@end
