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
#import "BCTrafikLabIntegrationManager.h"

@interface BCViewController : UIViewController <BCAppLocationManagerDelegate,BCTrafikLabIntegrationDelegate>

@property (retain, nonatomic) IBOutlet UITextView *resultTextView;

- (void)getNearByDepartures;

@end
