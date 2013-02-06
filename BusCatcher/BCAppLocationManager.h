//
//  BCAppLocationManager.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol BCAppLocationManagerDelegate <NSObject>
@required
- (void)queryLocationComplete:(CLLocationCoordinate2D) locationCoordinate2D;
@end

@interface BCAppLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic,weak) id<BCAppLocationManagerDelegate> delegate;

- (void)queryLocation;

@end
