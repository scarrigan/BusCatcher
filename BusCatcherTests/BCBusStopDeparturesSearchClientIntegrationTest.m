//
//  BCBusStopDeparturesSearchClientIntegrationTest.m
//  BusCatcher
//
//  Created by Steve Carrigan on 2/7/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCBusStopDeparturesSearchClientIntegrationTest.h"

@implementation BCBusStopDeparturesSearchClientIntegrationTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    client = [[BCBusStopDeparturesSearchClient alloc] init];
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

- (void)testGetDeparturesFromGullmarsplan
{
    BCBusStop *busStop = [[BCBusStop alloc] init];
    [busStop setBusStopName:@"Gullmarsplan"];
    [busStop setBusStopId:[[NSNumber alloc] initWithInt:9189]];
    [client searchForDeparturesBySLSiteId:busStop andWithTimeWindow:@"30"];
    [self waitForProcessing:5.0];
    STAssertTrue(callbackInvoked,@"Delegate should send searchForDeparturesBySLSiteIdResult: within 5 seconds.");
}

#pragma mark BCBusStopDeparturesSearchClient
- (void)searchForDeparturesBySLSiteIdResult:(BCBusStop *)busStop
{
    STAssertTrue([[busStop departures] count] > 0, @"There are always departures from Gullmarsplan");
    callbackInvoked = YES;
}


@end
