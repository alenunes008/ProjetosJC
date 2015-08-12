//
//  ModelKey.m
//  KeyStoreTeste
//
//  Created by Alex Nunes on 12/03/15.
//  Copyright (c) 2015 Mobilicidade. All rights reserved.
//

#import "ModelKey.h"
#import "Constantes.h"

@implementation ModelKey

#pragma mark - Keychain Storage

+ (void)storeAuthenticationInKeychain:(NSDictionary *)authInfo
{
    // Build the keychain query
    NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          (__bridge_transfer NSString *)kSecClassGenericPassword, (__bridge_transfer NSString *)kSecClass,
                                          kKeychainAccount, kSecAttrService,
                                          kKeychainAccount, kSecAttrAccount,
                                          kCFBooleanTrue, kSecReturnAttributes,
                                          nil];
    
    CFTypeRef resData = NULL;
    
    // If there's a token stored for this user, delete it first
    CFDictionaryRef query = (__bridge_retained CFDictionaryRef) keychainQuery;
    SecItemDelete(query);
    CFRelease(query);
    
    // Add the token dictionary to the query
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:authInfo]
                      forKey:(__bridge_transfer NSString *)kSecValueData];
    
    // Add the token data to the keychain
    // Even if we never use resData, replacing with NULL in the call throws EXC_BAD_ACCESS
    query = (__bridge_retained CFDictionaryRef) keychainQuery;
    SecItemAdd(query, (CFTypeRef *) &resData);
    CFRelease(query);
}

+ (NSMutableDictionary *)retrieveAuthenticationFromKeychain
{
    // Build the keychain query
    NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          (__bridge_transfer NSString *)kSecClassGenericPassword, (__bridge_transfer NSString *)kSecClass,
                                          kKeychainAccount, kSecAttrService,
                                          kKeychainAccount, kSecAttrAccount,
                                          kCFBooleanTrue, kSecReturnData,
                                          kSecMatchLimitOne, kSecMatchLimit,
                                          nil];
    
    // Get the token data from the keychain
    CFTypeRef resData = NULL;
    NSMutableDictionary *tokenDictionary = nil;
    
    // Get the token dictionary from the keychain
    CFDictionaryRef query = (__bridge_retained CFDictionaryRef) keychainQuery;
    
    if (SecItemCopyMatching(query, (CFTypeRef *) &resData) == noErr)
    {
        NSData *resultData = (__bridge_transfer NSData *)resData;
        
        if (resultData)
            tokenDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:resultData];
    }
    
    CFRelease(query);
    
    return tokenDictionary;
}

+ (BOOL)hasAutenticationInKeychain
{
    return [[self class] retrieveAuthenticationFromKeychain] != nil;
}

+ (void)removeAuthenticationFromKeychain
{
    // Build the keychain query
    NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          (__bridge_transfer NSString *)kSecClassGenericPassword, (__bridge_transfer NSString *)kSecClass,
                                          kKeychainAccount, kSecAttrService,
                                          kKeychainAccount, kSecAttrAccount,
                                          kCFBooleanTrue, kSecReturnAttributes,
                                          nil];
    
    // If there's a token stored for this user, delete it
    CFDictionaryRef query = (__bridge_retained CFDictionaryRef) keychainQuery;
    SecItemDelete(query);
    CFRelease(query);
}

@end
