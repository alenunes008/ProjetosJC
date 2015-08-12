//
//  ModelKey.h
//  KeyStoreTeste
//
//  Created by Alex Nunes on 12/03/15.
//  Copyright (c) 2015 Mobilicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelKey : NSObject

+ (void)storeAuthenticationInKeychain:(NSDictionary *)authInfo;
+ (BOOL)hasAutenticationInKeychain;
+ (NSMutableDictionary *)retrieveAuthenticationFromKeychain;
+ (void)removeAuthenticationFromKeychain;

@end
