//
//  PerfilViewController.m
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 10/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import "PerfilViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "Usuario.h"
#import "ModelKey.h"
#import "Dados.h"
#import "Constantes.h"
#import "UserModel.h"
#import "Times.h"
#import "Facade.h"
#import "selecaoTimesCollectionViewCell.h"


@interface PerfilViewController ()<FacadeDelegate>
@property (nonatomic,strong)NSMutableArray *arrayTimes;

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UICollectionView *timesCollection;
@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtNasc;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UISwitch *switIncJogo;
@property (weak, nonatomic) IBOutlet UISwitch *switFimJog;
@property (weak, nonatomic) IBOutlet UISwitch *switGols;

@property (nonatomic,strong)Usuario *user;


@end

@implementation PerfilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arrayTimes = [[NSMutableArray alloc]init];
   _user = [[ModelKey retrieveAuthenticationFromKeychain]valueForKey:kKeyUsuario];
   
    NSURL *urlImg = [NSURL URLWithString:_user.imgAvatar];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlImg];
    
    _imgAvatar.layer.cornerRadius = _imgAvatar.frame.size.height / 2;
    _imgAvatar.layer.masksToBounds = YES;
    _imgAvatar.layer.borderWidth = 0;
    _imgAvatar.contentMode = UIViewContentModeScaleAspectFill;

    [_imgAvatar setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"desconhecido_bandeira_cartao"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           _imgAvatar.image = image;
                                           
                                       } failure:nil];


    UserModel * networking = [UserModel getInstance];
    [networking setDelegate:self];
    [networking listPlaces:urlSelecaoTimes];
    
    _txtNome.text  = _user.nome;
    _txtNasc.text  = _user.aniversario;
    _txtEmail.text = _user.email;
    
    _switIncJogo.transform = CGAffineTransformMakeScale(0.75, 0.75);
    _switFimJog.transform  = CGAffineTransformMakeScale(0.75, 0.75);
    _switGols.transform    = CGAffineTransformMakeScale(0.75, 0.75);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark FacadeDelegate
- (void)processSuccessful: (BOOL)success dataReceived: (id)data{
    

    NSMutableArray  *_myArray = (NSMutableArray*)[data objectForKey:@"selecaoTimes"][@"pernambucano2015"];

    for (NSDictionary *s in _myArray) {
        Times* times = [[Times alloc]init];
        [times createTimes:s];
        [_arrayTimes addObject:times];
      }

    [_timesCollection reloadData];
}

- (void)didFailWithError:(NSError *)error{


}

#pragma mark UICollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arrayTimes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    selecaoTimesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"selecaoTimesCollectionViewCellID" forIndexPath:indexPath];
    Times * times  = [_arrayTimes objectAtIndex:indexPath.row];
    [cell setTimes:times];
    return cell;
}


#pragma mark action logical

- (IBAction)actionSalvar:(id)sender {
    
    
    NSDictionary *parameters = @{@"intFacebookId": _user.identificador,
                                 @"strNome":_txtNome.text,
                                 @"strEmail":_txtEmail.text,
                                 @"strDataNascimento":_txtNasc.text,
                                 @"intIdTime":@"26",
                                 @"intGol":[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:_switGols.on]],
                                 @"intInicio":[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:_switIncJogo.on]],
                                 @"intFim":[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:_switFimJog.on]],
                                 @"strToken":@"545464654646464"};
    NSLog(@"Parm: %@",parameters);
    
    UserModel * networking = [UserModel getInstance];
    [networking setDelegate:self];
    [networking postUser:parameters];
    
}


@end
