//
//  BCBusStopDeparturesSearchClient.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCBusStopDeparturesSearchClient.h"
#import "BCApiKeyManager.h"
#import "AFNetworking.h"
#import "BCBusStop.h"

@implementation BCBusStopDeparturesSearchClient

@synthesize delegate=_delegate;

- (void)searchForDeparturesBySLSiteId:(BCBusStop *)busStop andWithTimeWindow:(NSString *)timeWindow
{
    NSString *baseUrl = @"https://api.trafiklab.se/sl/realtid/GetDpsDepartures.json?";
    NSString *key = [[BCApiKeyManager sharedManager] valueForApiKey:@"SLDpsDepartures"];
    NSString *_siteId = [@"&siteId=" stringByAppendingString:[[busStop busStopId] stringValue]];
    NSString *_timeWindow = [@"&timeWindow=" stringByAppendingString:timeWindow];

    NSString *urlString = [baseUrl stringByAppendingString:_siteId];
    urlString = [urlString stringByAppendingString:_timeWindow];
    urlString = [urlString stringByAppendingString:key];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                
        id departures = [[[JSON valueForKeyPath:@"DPS"] valueForKeyPath:@"Buses"] valueForKey:@"DpsBus"];
        
        if ([departures isKindOfClass:[NSArray class]]) { // FOR MORE THAN ONE RESULT
            for (NSDictionary *departure in departures){
                if ([[departure valueForKey:@"TransportMode"] isEqualToString:@"BUS"]) {
                    [busStop addDepartureFromDictionary:departure];
                }
            }
        } else if ([departures isKindOfClass:[NSDictionary class]]) {
            if ([[departures valueForKey:@"TransportMode"] isEqualToString:@"BUS"]) {
                [busStop addDepartureFromDictionary:departures];
            }
        }
        
        if ( [_delegate respondsToSelector:@selector(searchForDeparturesBySLSiteIdResult:)] ) {
            [_delegate searchForDeparturesBySLSiteIdResult:busStop];
        }
        
    } failure:nil];
    
    [operation start];
}

@end
