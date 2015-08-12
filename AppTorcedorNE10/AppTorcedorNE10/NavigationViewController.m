//
//  NavigationViewController.m
//  AppTorcedorNE10
//
//  Created by Tecnologia SJCC on 10/08/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];

}
-(void)viewDidAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
     self.navigationController.navigationBarHidden = YES;

    [super viewDidAppear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
