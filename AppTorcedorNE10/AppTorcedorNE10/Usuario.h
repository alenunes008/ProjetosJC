//
//  Usuario.h
//  AppTorcedor
//
//  Created by Tecnologia SJCC on 13/07/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Usuario : NSObject

@property(nonatomic,strong)NSString *nome;
@property(nonatomic,strong)NSString *aniversario;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)Usuario *usuario;
@property(nonatomic,strong)NSString * imgAvatar;
@property(nonatomic,strong)NSString *identificador;


+ (id) defaultHandler;
- (Usuario*)reloadDados;


@end
