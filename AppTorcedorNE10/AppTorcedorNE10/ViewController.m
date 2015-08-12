//
//  ViewController.m
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 10/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import "ViewController.h"
#import "Usuario.h"
#import "ModelKey.h"
#import "Constantes.h"
#import "UserModel.h"
#import "Dados.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()<FacadeDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    if ([[[ModelKey retrieveAuthenticationFromKeychain]valueForKey:kKeychainStauts]intValue] == 2) {
//        _btnLogin.alpha = 0;
//        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(actionLogar) userInfo:nil repeats:NO];
//        
//    }else{
//        
//        UserModel * networking = [UserModel getInstance];
//        [networking setDelegate:self];
//        [networking listPlaces:urlGetUser];
//        
//  }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLoginFacebook:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends",@"user_birthday"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                NSLog(@"result is:%@",result);
                [self fetchUserInfo];
                // Do work
            }
        }
    }];
}

#pragma mark Logical Facebook
-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
//                 NSLog(@"resultis:%@",result);
                 Usuario *usuario = [[Usuario alloc]init];
                 [usuario setNome:result[@"name"]];
                 [usuario setEmail:result[@"email"]];
                 [usuario setAniversario:result[@"birthday"]];
                 [usuario setImgAvatar:result[@"picture"][@"data"][@"url"]];
                 [usuario setIdentificador:result[@"id"]];
                 NSMutableArray *localPlaces = [[NSMutableArray alloc]init];
                 [localPlaces addObject:usuario];

                 [[Usuario defaultHandler]setUsuario:usuario];
                 [[Dados defaultHandler] setDados:localPlaces];
                 
                 NSDictionary *dicUser = @{kKeychainUsername:result[@"name"],kKeychainPassword:result[@"id"], kKeychainStauts:@2,kKeyUsuario:usuario};
                 [ModelKey storeAuthenticationInKeychain:dicUser];
                         [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(actionLogar) userInfo:nil repeats:NO];

             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
}
#pragma mark FacadeDelegate
- (void)processSuccessful: (BOOL)success dataReceived: (id)data{
    
    //    NSLog(@"Data: %@", data);
//    [_hub hide];
    
    //        for (NSDictionary *pagamento in [data valueForKey:@"places"]) {
    //            Place *cartaoNepos = [[Place alloc] init];
    //            [cartaoNepos createPlaces:pagamento];
    //            [_places addObject:cartaoNepos];
    //        }
    //        [self performSegueWithIdentifier:@"segueRootMap" sender:self];
}

- (void)didFailWithError:(NSError *)error{
    
    NSLog(@"Error %@",error);
}


- (void)viewDidAppear:(BOOL)animated {
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationItem.leftBarButtonItem = nil;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [super viewDidAppear:animated];
}

#pragma mark Logical Controller
-(void)actionLogar{
    
    [self performSegueWithIdentifier:@"tabbarID" sender:self];
    
}
@end
