//
//  Fachada.m
//  TesteFacede
//
//  Created by Alex Nunes da Silva on 12/25/13.
//  Copyright (c) 2013 Alex Nunes da Silva. All rights reserved.
//

#import "UserModel.h"
#import "Util.h"
#import "Constantes.h"
#import "AFNetworking.h"


@interface UserModel ()
@property(nonatomic,strong) NSMutableArray * collection;


@end

@implementation UserModel

__strong static UserModel * instanceOf = nil;

// alloc and initializes the Enderecos
+ (UserModel*) getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceOf = [[UserModel alloc] init];
    });
    
    return instanceOf;
}


- (id) init
{
    if (self == [super init]) {
        _collection =[[NSMutableArray alloc]init];
        
    }
    return self;
}



- (void)friendsNetworkGet :(NSString * )url{
    NSError		 * error;
    
    NSData *JSONData = [NSData dataWithContentsOfFile:url options:NSDataReadingMappedIfSafe error:nil];
    id responseObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error];
    
	NSLog(@"---------------------------------------------------------------------->");
	NSLog(@"Facade-> URL string: %@",url);
	NSLog(@"---------------------------------------------------------------------->");
	
    if (responseObject) {
        [delegate processSuccessful:YES dataReceived:responseObject];
    }
    
    [delegate didFailWithError:error];
}


- (void)listPlaces:(NSString * )url{
    
    NSURL *localUrl = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:localUrl
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:45.0];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
        
        if (!error) {
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (responseObject) {
                    [delegate processSuccessful:YES dataReceived:responseObject];
                }

        } else {
            [delegate didFailWithError:error];
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }];

}


- (void)postUser:(NSDictionary *)parameters{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlNovoUsuario parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


@end
