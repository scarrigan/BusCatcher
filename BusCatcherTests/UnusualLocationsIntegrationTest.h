//
//  UnusualLocationsIntegrationTest.h
//  BusCatcher
//
//  Created by Steve Carrigan on 2/7/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "BCBusStopSearchClient.h"

@interface UnusualLocationsIntegrationTest : SenTestCase <BCBusStopSearchDelegate>
{
    @private
    BCBusStopSearchClient *client;
    BOOL callbackInvoked;
}

@end
