//
//  BCDeparture.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/24/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCDeparture : NSObject

@property (nonatomic,retain) NSString *transportMode;
@property (nonatomic,retain) NSString *lineNumber;
@property (nonatomic,retain) NSString *destination;
@property (nonatomic,retain) NSString *displayTime;

- (id)initWithDictionary:(NSDictionary *)departure;

@end
