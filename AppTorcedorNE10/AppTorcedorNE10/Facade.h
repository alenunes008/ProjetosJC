//
//  Facade.h
//  PocketStore
//
//  Created by Felipe Andrade on 11/30/12.
//  Copyright (c) 2012 i2 Mobile Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
//#import "MBProgressHUD.h"



@protocol FacadeDelegate;

@interface Facade : NSObject <NSURLConnectionDataDelegate>
{
    NSURL *theURL;
    id <FacadeDelegate> delegate;
}

//typedef enum{
//	FacadeServiceGetUser	    = 1,
//	FacadeSeriveFeed	        = 2,
//	FacadeServiceGetMakeUpPro	= 3,
//	FacadeServiceGetComment  	= 4,
//	FacadeServiceGetConnections = 5,
//	FacadeServiceGetLikes   	= 6,
//	FacadeServiceSearch 		= 7,
//	FacadeServiceCadastroCont   = 8,
//	FacadeServiceComment		= 9,
//    FacadeServiceProfile    = 10,
//} ServiceRequest;

@property id delegate;

+ (id)getInstance;
- (void)queryService:(NSDictionary*)gets AndPost:(NSDictionary*)posts;
- (AFHTTPRequestOperationManager*)connect:(NSString*)urlString;
- (NSString*)isNull:(NSString*)myString;
@end

@protocol FacadeDelegate <NSObject>

@required
- (void)processSuccessful: (BOOL)success dataReceived: (id)data;
- (void)didFailWithError:(NSError *)error;

@optional
- (void)alertMensagem:(NSString*)mensagem;
@end
