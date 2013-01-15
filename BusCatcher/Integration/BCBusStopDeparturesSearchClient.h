//
//  BCBusStopDeparturesSearchClient.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BCBusStopDeparturesSearchDelegate <NSObject>
@required
- (void)searchForDeparturesBySLSiteIdResult:(NSArray *)buses;
@end

@interface BCBusStopDeparturesSearchClient : NSObject

@property (strong,nonatomic) id delegate;

- (void)searchForDeparturesBySLSiteId:(NSNumber *)siteId andWithTimeWindow:(NSString *)timeWindow;

@end
