//
//  BCBusStopSearchClientIntegrationTest.m
//  BusCatcher
//
//  Created by Steve Carrigan on 2/6/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCBusStopSearchClientIntegrationTest.h"

@implementation BCBusStopSearchClientIntegrationTest

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

- (void)testGetBusStopsFromLocationMyHome
{
    [client searchByCoordinate:CLLocationCoordinate2DMake(59.176888, 18.161941) andWithinRange:@"500"];
    [self waitForProcessing:3.0];
    STAssertTrue(callbackInvoked,@"Delegate should send searchByCoordinateResult: within 3 seconds.");
}

#pragma mark BCBusStopSearchClientDelegate
- (void)searchByCoordinateResult:(NSArray *)busStops
{
    STAssertNotNil(busStops, @"expected a non nil value");
    STAssertTrue([busStops count] == 3, @"There are three bus stops within 500 meters from location My Home.");
    callbackInvoked = YES;
}

- (void)testGetSLBusStopNameFromName
{
    BCBusStop *busStop = [[BCBusStop alloc] init];
    [busStop setBusStopName:@"Kulfångsgatan"];
    [client searchForSLBusStopByName:busStop];
    [self waitForProcessing:5.0];
    STAssertTrue(callbackInvoked,@"Delegate should send searchSLBusStopByNameResult: within 5 seconds.");
}

#pragma mark BCBusStopSearchClientDelegate
- (void)searchSLBusStopByNameResult:(NSArray *)busStops
{
    STAssertNotNil(busStops, @"expected a non nil value");
    STAssertTrue([busStops count] == 1, @"There is exact one match for the given bus stop name.");
    callbackInvoked = YES;
}

@end
