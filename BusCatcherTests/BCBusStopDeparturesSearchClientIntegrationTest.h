//
//  BCBusStopDeparturesSearchClientIntegrationTest.h
//  BusCatcher
//
//  Created by Steve Carrigan on 2/7/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "BCBusStopDeparturesSearchClient.h"

@interface BCBusStopDeparturesSearchClientIntegrationTest : SenTestCase <BCBusStopDeparturesSearchDelegate>
{
    @private
    BCBusStopDeparturesSearchClient *client;
    BOOL callbackInvoked;
}

@end
