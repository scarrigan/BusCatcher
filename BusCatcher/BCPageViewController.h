//
//  BCPageViewController.h
//  BusCatcher
//
//  Created by Steve Carrigan on 2/12/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCBusStop.h"

@interface BCPageViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UILabel *headerLabel;
@property (nonatomic, retain) IBOutlet UITableView *departuresTable;
@property (nonatomic, retain) BCBusStop *busStop;
@property (nonatomic, retain) NSArray *departures;

@end
