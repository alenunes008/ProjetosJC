
//
//  Usuario.m
//  AppTorcedor
//
//  Created by Tecnologia SJCC on 13/07/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import "Usuario.h"

@implementation Usuario

@synthesize usuario = _usuario;

+ (id) defaultHandler
{
    static dispatch_once_t pred = 0;
    __strong static id defaultHandler = nil;
    dispatch_once(&pred, ^{
        defaultHandler = [[self alloc] init];
        
    });
    
    [defaultHandler reloadDados];
    [defaultHandler usuario];
    
    return defaultHandler;
}
- (Usuario*)reloadDados{
    
    return _usuario;
}


#pragma mark - ENCODER: Método necessário para colocar o pais na lista de Favoritos
-(void)encodeWithCoder:(NSCoder *)encoder
{
    // Essas declarações são necessárias para o armazenamento da informação.
    [encoder encodeObject:_nome forKey:@"nome"];
    [encoder encodeObject:_email forKey:@"aniversario"];
    [encoder encodeObject:_aniversario forKey:@"email"];
    [encoder encodeObject:_imgAvatar forKey:@"avatar"];
    [encoder encodeObject:_identificador forKey:@"identificador"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    // Essas declarações são necessárias para a recuperação da informação.
    _nome           = [decoder decodeObjectForKey:@"nome"];
    _email          = [decoder decodeObjectForKey:@"aniversario"];
    _aniversario    = [decoder decodeObjectForKey:@"email"];
    _imgAvatar      = [decoder decodeObjectForKey:@"avatar"];
    _identificador  = [decoder decodeObjectForKey:@"identificador"];

    return self;
}

@end
