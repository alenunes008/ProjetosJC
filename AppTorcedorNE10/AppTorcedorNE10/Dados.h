//
//  Dados.h
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 10/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Usuario.h"

@interface Dados : NSObject

@property(nonatomic,retain)NSMutableArray *dados;
@property(nonatomic,strong)Usuario *user;


//-(id)init;
+ (id) defaultHandler;
- (NSMutableArray*)reloadDados;


@end
