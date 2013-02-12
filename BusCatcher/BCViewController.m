//
//  BCViewController.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BCViewController.h"

@implementation BCViewController

@synthesize pageController=_pageController, pageControl=_pageControl, pageContent=_pageContent;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = [[self view] center];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    
    appLocationManager = [[BCAppLocationManager alloc] init];
    [appLocationManager setDelegate:self];
    
    integrationManager = [[BCTrafikLabIntegrationManager alloc] init];
    [integrationManager setDelegate:self];
}

- (void)setupPageController
{
    _pageControl.numberOfPages = [_pageContent count];
    
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                        forKey: UIPageViewControllerOptionSpineLocationKey];
    
    _pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           options: options];
    
    _pageController.dataSource = self;
    
    //CGRect rect = CGRectMake(0, 0, 320, 500);
    CGRect rect2 = [[self view] bounds];
    //NSInteger a = rect2.size.width;
    
    CGRect rect = CGRectMake(10, 10, rect2.size.width-10, rect2.size.height-60);

    [[_pageController view] setFrame:rect];//;
    
    BCPageViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [_pageController setViewControllers:viewControllers
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];
    
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    [_pageController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNearByDepartures
{
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [indicator startAnimating];
    
    // Query Location and Initiate Bus Stop lookup
    _pageContent = [[NSArray alloc] init];
    [appLocationManager queryLocation];
}

#pragma mark BCAppLocationManagerDelegate
- (void)queryLocationComplete:(CLLocationCoordinate2D)locationCoordinate2D
{
    [integrationManager getBusStopsFromLocation:locationCoordinate2D andWithinRadius:@"500"];
}

#pragma mark BCTrafikLabIngegrationDelegate
- (void)busStopsFromLocation:(NSArray *)busStops {
    for (BCBusStop * busStop in busStops) {
        [integrationManager getDeparturesFromBusStop:busStop];
    }
}

- (void)departuresFromBusStop:(BCBusStop *)busStop {
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:_pageContent];
    [tmp addObject:busStop];
    _pageContent = [NSArray arrayWithArray:tmp];
    [self setupPageController];
    [indicator stopAnimating];
}

#pragma mark BCPageViewControllerDelegate
- (BCPageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.pageContent count] == 0) ||
        (index >= [self.pageContent count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    BCPageViewController *dataViewController = [[BCPageViewController alloc] initWithNibName:@"BCPageViewController" bundle:nil];
    BCBusStop *bcBusStop = [self.pageContent objectAtIndex:index];
    dataViewController.headerLabel.text = [bcBusStop busStopName];
    dataViewController.busStop = [self.pageContent objectAtIndex:index];
    dataViewController.view.layer.cornerRadius = 10;
    dataViewController.departuresTable.layer.cornerRadius = 10;
    dataViewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(BCPageViewController *)viewController
{
    return [self.pageContent indexOfObject:viewController.busStop];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController: (BCPageViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        _pageControl.currentPage = 0;
        return nil;
    }
    _pageControl.currentPage = index;
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(BCPageViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    _pageControl.currentPage = index;
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end
