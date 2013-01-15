//
//  BCBusStop.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCBusStop.h"

@implementation BCBusStop

@synthesize busStopId,busStopName,xCoordinate,yCoordinate;

- (id)initWithResRobotDictionary:(NSDictionary *)busStop
{
    if (self = [super init]) {
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

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ x:%@ y:%@", busStopId, busStopName, xCoordinate, yCoordinate];
}

@end
