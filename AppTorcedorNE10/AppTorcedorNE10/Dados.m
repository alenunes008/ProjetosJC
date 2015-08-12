//
//  Dados.m
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 10/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import "Dados.h"

@implementation Dados
@synthesize dados = _dados;
@synthesize user  = _user;

+ (id) defaultHandler
{
    static dispatch_once_t pred = 0;
    __strong static id defaultHandler = nil;
    dispatch_once(&pred, ^{
        defaultHandler = [[self alloc] init];
    });
    
    [defaultHandler reloadDados];
    [defaultHandler dados];
    [defaultHandler user];
    
    return defaultHandler;
}

- (NSMutableArray*)reloadDados{
    
    return _dados;
}


@end
