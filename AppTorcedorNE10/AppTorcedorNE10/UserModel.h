//
//  Fachada.h
//  TesteFacede
//
//  Created by Alex Nunes da Silva on 12/25/13.
//  Copyright (c) 2013 Alex Nunes da Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facade.h"
//#import "User.h"
@interface UserModel : Facade


+ (id)getInstance;
- (void)friendsNetworkGet :(NSString * )url;
- (void)listPlaces:(NSString * )url;
- (void)postUser:(NSDictionary *)parameters;


@end
