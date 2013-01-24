//
//  BCBusStopDeparturesSearchClient.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCBusStop.h"

@protocol BCBusStopDeparturesSearchDelegate <NSObject>
@required
- (void)searchForDeparturesBySLSiteIdResult:(BCBusStop *)busStop;
@end

@interface BCBusStopDeparturesSearchClient : NSObject

@property (strong,nonatomic) id delegate;

- (void)searchForDeparturesBySLSiteId:(BCBusStop *)busStop andWithTimeWindow:(NSString *)timeWindow;

@end
