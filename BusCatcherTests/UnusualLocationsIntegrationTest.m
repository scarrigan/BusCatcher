//
//  UnusualLocationsIntegrationTest.m
//  BusCatcher
//
//  Created by Steve Carrigan on 2/7/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "UnusualLocationsIntegrationTest.h"

@implementation UnusualLocationsIntegrationTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    client = [[BCBusStopSearchClient alloc] init];
    [client setDelegate:self];
    callbackInvoked = NO;
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)waitForProcessing:(NSTimeInterval)timeout
{
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:timeout]];
}

- (void)testGetBusStopsFromKlarabergsviadukten
{
    [client searchByCoordinate:CLLocationCoordinate2DMake(59.33076,18.056452) andWithinRange:@"500"];
    [self waitForProcessing:5.0];
    STAssertTrue(callbackInvoked,@"Delegate should send searchByCoordinateResult: within 5 seconds.");
}

#pragma mark BCBusStopSearchClientDelegate
- (void)searchByCoordinateResult:(NSArray *)busStops
{
    STAssertNotNil(busStops, @"expected a non nil value");
    //NSLog(@"Klarabergsviadukten stops %@", [busStops description]);
    callbackInvoked = YES;
}

- (void)testGetSLBusStopNameFromName
{
    BCBusStop *busStop = [[BCBusStop alloc] init];
    [busStop setBusStopName:@"Stockholm Central Vasagatan \n\n"];
    [client searchForSLBusStopByName:busStop];
    [self waitForProcessing:5.0];
    STAssertTrue(callbackInvoked,@"Delegate should send searchSLBusStopByNameResult: within 5 seconds.");
}

#pragma mark BCBusStopSearchClientDelegate
- (void)searchSLBusStopByNameResult:(NSArray *)busStops
{
    STAssertNotNil(busStops, @"expected a non nil value");
    //NSLog(@"SL Bus Stop matches value %@", [busStops description]);
    STAssertTrue([busStops count] > 1, @"There is more than one match for the given bus stop name.");
    callbackInvoked = YES;
}

@end
