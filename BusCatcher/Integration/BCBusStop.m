//
//  BCBusStop.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCBusStop.h"
#import "BCDeparture.h"

@implementation BCBusStop

@synthesize busStopId,busStopName,xCoordinate,yCoordinate,departures;

- (NSString *)shortBusStopName
{
    NSRange range = [busStopName rangeOfString:@"("];
    if (range.location != NSNotFound) {
        return [NSString stringWithString:[busStopName substringToIndex:range.location] ];
    }
    return busStopName;
}

- (NSArray *)departuresAsStringArray
{
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (BCDeparture *departure in departures) {
        [tmp addObject:[departures description]];
    }
    return [[NSArray alloc] initWithArray:tmp];
}

- (id)initWithResRobotDictionary:(NSDictionary *)busStop
{
    if (self = [super init]) {
        departures = [[NSMutableArray alloc] init];
        [self setBusStopName:[busStop valueForKey:@"name"]];
        [self setBusStopId:[busStop valueForKey:@"id"]];
        [self setXCoordinate:[busStop valueForKey:@"x"]];
        [self setYCoordinate:[busStop valueForKey:@"y"]];
    }
    return self;
}

- (id)initWithSLDictionary:(NSDictionary *)busStop
{
    if (self = [super init]) {
        [self setBusStopName:[busStop valueForKey:@"Name"]];
        [self setBusStopId:[busStop valueForKey:@"Number"]];
    }
    return self;
}

- (void)enrichWithSLDictionary:(NSDictionary *)busStop
{
    [self setBusStopName:[busStop valueForKey:@"Name"]];
    [self setBusStopId:[busStop valueForKey:@"Number"]];
}

- (void)addDepartureFromDictionary:(NSDictionary *)departure {
    BCDeparture *dep = [[BCDeparture alloc] initWithDictionary:departure];
    NSMutableArray *tmpDep = [[NSMutableArray alloc] initWithArray:departures];
    [tmpDep addObject:dep];
    departures = [[NSArray alloc] initWithArray:tmpDep];
}

- (NSString *)description
{
    NSString *printDepartures = @"\n";
    for (BCDeparture *dep in [self departures]) {
        printDepartures = [printDepartures stringByAppendingString:[dep description]];
        printDepartures = [printDepartures stringByAppendingString:@"\n"];
    }
    printDepartures = [printDepartures stringByAppendingString:@"\n"];

    return [NSString stringWithFormat:@"%@ %@", busStopName , printDepartures];
}

@end
