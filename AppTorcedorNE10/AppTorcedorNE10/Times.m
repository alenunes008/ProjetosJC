//
//  Times.m
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 11/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import "Times.h"

@implementation Times


- (void)createTimes:(NSObject*)obj{
  
    _identificador = [ obj valueForKey:@"id"];
    _nome          = [obj valueForKey:@"nome"];
    _sigla         = [obj valueForKey:@"sigla"];
    _escudo        = [obj valueForKey:@"escudo"];
    _pontos        = [obj valueForKey:@"pontos"];
    _jogos         = [obj valueForKey:@"jogos"];
    _vitoria       = [obj valueForKey:@"vitorias"];
    _empate        = [obj valueForKey:@"empates"];
    _derrotas      = [obj valueForKey:@"derrotas"];
    _golsPositivos = [obj valueForKey:@"golsPositivos"];
    _goslNegativos = [obj valueForKey:@"golsNegativos"];
    _saldoGols     = [obj valueForKey:@"saldoGols"];
    _aproveitamento= [obj valueForKey:@"aproveitamento"];
}

@end
