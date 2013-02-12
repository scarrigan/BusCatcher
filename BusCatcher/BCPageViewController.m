//
//  BCPageViewController.m
//  BusCatcher
//
//  Created by Steve Carrigan on 2/12/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCPageViewController.h"
#import "BCDeparture.h"

@interface BCPageViewController ()

@end

@implementation BCPageViewController

@synthesize headerLabel=_headerLabel,departuresTable,departures,busStop=_busStop;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.departures = [NSArray arrayWithObjects:@"n/a", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBusStop:(BCBusStop *)busStop
{
    _busStop = busStop;
    if ([_busStop departures] == NULL) {
        self.departures = [NSArray arrayWithObjects:@"Inga avgångar", nil];
    } else {
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (BCDeparture *dep in [busStop departures]) {
            [tmp addObject:[dep description]];
        }
        self.departures = [[NSArray alloc] initWithArray:tmp];
    }
}

#pragma mark UITableViewControllerDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_busStop shortBusStopName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [departures count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [departuresTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *cellText = [departures objectAtIndex:indexPath.row];
    cell.textLabel.text = cellText;
    cell.textLabel.font =[UIFont boldSystemFontOfSize:16];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

@end
