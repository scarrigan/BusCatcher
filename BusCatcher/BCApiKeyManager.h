//
//  BCApiKeyManager.h
//  BusCatcher
//
//  Created by Steve Carrigan on 1/15/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCApiKeyManager : NSObject {
    @private
    NSMutableDictionary *apiKeys;
}

+ (BCApiKeyManager *)sharedManager;

- (NSString *)valueForApiKey:(NSString *)key;

@end
