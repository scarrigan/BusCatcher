//
//  BCBusStop.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/14/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCBusStop : NSObject

@property (nonatomic,retain) NSString *busStopId;
@property (nonatomic,retain) NSString *busStopName;
@property (nonatomic,retain) NSString *xCoordinate;
@property (nonatomic,retain) NSString *yCoordinate;

- (id)initWithResRobotDictionary:(NSDictionary *)busStop;
- (id)initWithSLDictionary:(NSDictionary *)busStop;
- (void)enrichWithSLDictionary:(NSDictionary *)busStop;

@end