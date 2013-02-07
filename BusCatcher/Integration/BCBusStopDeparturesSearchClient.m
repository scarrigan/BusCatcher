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
    //NSLog(@"URL %@ ", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
        
        id departures = [[[JSON valueForKeyPath:@"DPS"] valueForKeyPath:@"Buses"] valueForKey:@"DpsBus"];
        
        if ([departures isKindOfClass:[NSArray class]]) { // FOR MORE THAN ONE RESULT
            for (NSDictionary *departure in departures){
                NSString * transportMode = [departure valueForKey:@"TransportMode"];
                if ([transportMode isEqualToString:@"BUS"] || [transportMode isEqualToString:@"BLUEBUS"]) {
                    [busStop addDepartureFromDictionary:departure];
                }
            }
        } else if ([departures isKindOfClass:[NSDictionary class]]) {
            NSString * transportMode = [departures valueForKey:@"TransportMode"];
            if ([transportMode isEqualToString:@"BUS"] || [transportMode isEqualToString:@"BLUEBUS"]) {
                [busStop addDepartureFromDictionary:departures];
            }
        }
        
        if ( [_delegate respondsToSelector:@selector(searchForDeparturesBySLSiteIdResult:)] ) {
            [_delegate searchForDeparturesBySLSiteIdResult:busStop];
        } else {
            NSLog(@"%@ Does not repond to selector searchForDeparturesBySLSiteIdResult",[_delegate class]);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ett fel inträffade"
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
                                         
    }
    ];
    
    [operation start];
}

@end
