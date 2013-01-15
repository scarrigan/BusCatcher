//
//  BCApiKeyManager.m
//  BusCatcher
//
//  Created by Steve Carrigan on 1/15/13.
//  Copyright (c) 2013 Steve Carrigan. All rights reserved.
//

#import "BCApiKeyManager.h"

@implementation BCApiKeyManager

static BCApiKeyManager *sharedInstance = nil;

+ (BCApiKeyManager *)sharedManager {
    if(sharedInstance == nil) {
        sharedInstance = [[BCApiKeyManager alloc] init];
    }
    return sharedInstance;
}

- (id)init {
    if((self = [super init])) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"APIKeys"
                                                         ofType:@"strings"
                                                    inDirectory:nil
                                                forLocalization:nil];
        
        // compiled .strings file becomes a "binary property list"
        apiKeys = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return self;
}

- (NSString *)valueForApiKey:(NSString *)key
{
    return [apiKeys valueForKey:key];
}

@end
