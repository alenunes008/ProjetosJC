//
//  selecaoTimesCollectionViewCell.h
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 11/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Times.h"


@interface selecaoTimesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgEscudo;
@property(nonatomic,strong)Times * times;

@end
