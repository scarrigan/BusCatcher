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
#import "BCBusStop.h"
#import "BCApiKeyManager.h"
#import "BCPageViewController.h"

@interface BCViewController : UIViewController <BCAppLocationManagerDelegate,BCTrafikLabIntegrationDelegate,UIPageViewControllerDataSource>
{
    @private
    BCAppLocationManager *appLocationManager;
    BCTrafikLabIntegrationManager *integrationManager;
    UIActivityIndicatorView *indicator;
}

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) UIPageViewController *pageController;
@property (copy, nonatomic) NSArray *pageContent;

- (void)getNearByDepartures;

@end
