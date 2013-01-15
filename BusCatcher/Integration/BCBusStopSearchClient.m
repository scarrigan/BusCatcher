//
//  BCBusStationSearchClient.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCBusStopSearchClient.h"
#import "AFNetworking.h"
#import "BCBusStop.h"
#import "BCApiKeyManager.h"

@implementation BCBusStopSearchClient

@synthesize delegate=_delegate;

- (void)searchByCoordinate:(CLLocationCoordinate2D)coordinate2D andWithinRange:(NSString *)rangeInMeters
{
    NSString *baseUrl = @"https://api.trafiklab.se/samtrafiken/resrobot/StationsInZone.json?apiVersion=2.1";
    NSString *key = [[BCApiKeyManager sharedManager] valueForApiKey:@"ResRobotStationInZone"];
    NSString *centerX = [@"&centerX=" stringByAppendingString:[NSString stringWithFormat:@"%f",coordinate2D.longitude]];
    NSString *centerY = [@"&centerY=" stringByAppendingString:[NSString stringWithFormat:@"%f",coordinate2D.latitude]];
    NSString *radius = [@"&radius=" stringByAppendingString:rangeInMeters];
    NSString *coordSys = @"&coordSys=WGS84";
    
    NSString *urlString = [baseUrl stringByAppendingString:centerX];
    urlString = [urlString stringByAppendingString:centerY];
    urlString = [urlString stringByAppendingString:radius];
    urlString = [urlString stringByAppendingString:coordSys];
    urlString = [urlString stringByAppendingString:key];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
  
        NSDictionary *stationsinzoneresult = [JSON valueForKeyPath:@"stationsinzoneresult"];
        id locations = [stationsinzoneresult valueForKeyPath:@"location"];
        NSMutableArray *busStops = [[NSMutableArray alloc] init];
        
        if ([locations isKindOfClass:[NSArray class]]) { // FOR MORE THAN ONE OBJECT
            for (NSDictionary *location in (NSArray *)locations) {
                BCBusStop *busStop = [[BCBusStop alloc] initWithResRobotDictionary:location];
                [busStops addObject:busStop];
            }
        } else if ([locations isKindOfClass:[NSDictionary class]]) { // FOR ONE OBJECT
            NSDictionary *location = (NSDictionary *)locations;
            BCBusStop *busStop = [[BCBusStop alloc] initWithResRobotDictionary:location];
            [busStops addObject:busStop];
        }
        
        if ( [_delegate respondsToSelector:@selector(searchByCoordinateResult:)] ) {
            [_delegate searchByCoordinateResult:busStops];
        }
        
    } failure:nil];
    
    [operation start];
}

- (void)searchForSLBusStopByName:(BCBusStop *)busStop
{
    NSString *baseURL = @"https://api.trafiklab.se/sl/realtid/GetSite.json?stationSearch=";
    NSString *key = [[BCApiKeyManager sharedManager] valueForApiKey:@"SLStationSearch"];
    NSString *urlString = [[NSString alloc] initWithString:baseURL];
    NSString *nameEncoded = [[busStop busStopName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlString = [urlString stringByAppendingString:nameEncoded];
    urlString = [urlString stringByAppendingString:key];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSMutableArray *busStops = [[NSMutableArray alloc] init];
        id sites = [[[JSON valueForKeyPath:@"Hafas"] valueForKeyPath:@"Sites"] valueForKeyPath:@"Site"];
        
        if ([sites isKindOfClass:[NSArray class]]) { // FOR MORE THAN ONE OBJECT
            for (NSDictionary *site in (NSArray *)sites) {
                BCBusStop *busStop = [[BCBusStop alloc] initWithSLDictionary:site];
                [busStops addObject:busStop];
            }
        } else if ([sites isKindOfClass:[NSDictionary class]]) { // FOR ONE OBJECT
            [busStop enrichWithSLDictionary:(NSDictionary *)sites];
            [busStops addObject:busStop];
        }
        
        if ( [_delegate respondsToSelector:@selector(searchSLBusStopByNameResult:)] ) {
            [_delegate searchSLBusStopByNameResult:busStops];
        }   
        
    } failure:nil];
    
    [operation start];
}


@end
