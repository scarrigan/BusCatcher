//
//  BCDeparture.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/24/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCDeparture.h"

@implementation BCDeparture

@synthesize transportMode,lineNumber,destination,displayTime;

- (id)initWithDictionary:(NSDictionary *)departure
{
    if (self = [super init]) {
        [self setDestination:[departure valueForKey:@"Destination"]];
        [self setDisplayTime:[departure valueForKey:@"DisplayTime"]];
        [self setLineNumber:[departure valueForKey:@"LineNumber"]];
        [self setTransportMode:[departure valueForKey:@"TransportMode"]];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@\t\t%@", lineNumber, destination, displayTime];
}

@end
