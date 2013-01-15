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

@implementation BCBusStopDeparturesSearchClient

@synthesize delegate=_delegate;

- (void)searchForDeparturesBySLSiteId:(NSNumber *)siteId andWithTimeWindow:(NSString *)timeWindow
{
    NSString *baseUrl = @"https://api.trafiklab.se/sl/realtid/GetDpsDepartures.json?";
    NSString *key = [[BCApiKeyManager sharedManager] valueForApiKey:@"SLDpsDepartures"];
    NSString *_siteId = [@"&siteId=" stringByAppendingString:[siteId stringValue]];
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
                NSLog(@"%@ %@ %@",[departure valueForKey:@"LineNumber"], [departure valueForKey:@"Destination"], [@"\t" stringByAppendingString:[departure valueForKey:@"DisplayTime"]]);
            }
        }
        
        if ( [_delegate respondsToSelector:@selector(searchForDeparturesBySLSiteIdResult:)] ) {
            [_delegate searchForDeparturesBySLSiteIdResult:nil];
        }
        
    } failure:nil];
    
    [operation start];
}

@end
