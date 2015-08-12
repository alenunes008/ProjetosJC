//
//  Times.h
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 11/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Times : NSObject

@property(nonatomic,strong)NSString* identificador;
@property(nonatomic,strong)NSString* nome;
@property(nonatomic,strong)NSString* sigla;
@property(nonatomic,strong)NSString* escudo;
@property(nonatomic,strong)NSString* pontos;
@property(nonatomic,strong)NSString* jogos;
@property(nonatomic,strong)NSString* vitoria;
@property(nonatomic,strong)NSString* empate;
@property(nonatomic,strong)NSString* derrotas;
@property(nonatomic,strong)NSString* golsPositivos;
@property(nonatomic,strong)NSString* goslNegativos;
@property(nonatomic,strong)NSString* saldoGols;
@property(nonatomic,strong)NSString* aproveitamento;

- (void)createTimes:(NSObject*)obj;

@end
