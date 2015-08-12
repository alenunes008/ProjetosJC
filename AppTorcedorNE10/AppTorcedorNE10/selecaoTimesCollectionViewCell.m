//
//  selecaoTimesCollectionViewCell.m
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 11/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import "selecaoTimesCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface selecaoTimesCollectionViewCell()

@end

@implementation selecaoTimesCollectionViewCell



-(void)setTimes:(Times *)times{

    NSURL *urlImg = [NSURL URLWithString:times.escudo];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlImg];

    [_imgEscudo setImageWithURLRequest:request
                      placeholderImage:[UIImage imageNamed:@"desconhecido_bandeira_cartao"]
                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                   _imgEscudo.image = image;
                                   
                               } failure:nil];

}
@end

