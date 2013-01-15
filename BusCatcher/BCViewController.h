//
//  BCViewController.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCAppLocationManager.h"
#import "BCBusStopSearchClient.h"
#import "BCBusStopDeparturesSearchClient.h"

@interface BCViewController : UIViewController <BCAppLocationManagerDelegate,BCBusStopSearchDelegate>

@end
