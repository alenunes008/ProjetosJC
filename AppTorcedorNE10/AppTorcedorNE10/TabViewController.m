//
//  TabViewController.m
//  AppTorcedor
//
//  Created by Tecnologia SJCC on 13/07/15.
//  Copyright (c) 2015 Tecnologia SJCC. All rights reserved.
//

#import "TabViewController.h"
#import "MPAdView.h"
#import "Constantes.h"

@interface TabViewController ()<MPAdViewDelegate>

@property (nonatomic,strong)  MPAdView *adView;


@end

@implementation TabViewController

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationItem.leftBarButtonItem = nil;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.adView = [[MPAdView alloc] initWithAdUnitId:BannerFooter
                                                size:MOPUB_BANNER_SIZE];
    self.adView.delegate = self;
    self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2,
                                   (self.view.bounds.size.height - MOPUB_BANNER_SIZE.height)-50,
                                   MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
    [self.view addSubview:self.adView];
    [self.adView loadAd];
    
    [self  setSelectedIndex:1];

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


#pragma mark MPAdviewDelegate
- (UIViewController *)viewControllerForPresentingModalView{
    
    return self;
}

@end
