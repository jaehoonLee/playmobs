//
//  FacebookViewController.m
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 6. 3..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (id)initWithURL:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.frame = CGRectMake(0, 0, 320, 460);
        NSURL * url = [NSURL URLWithString:urlStr];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        facebookView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [facebookView loadRequest:request];
        
        [self.view addSubview:facebookView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *buttonImage = [UIImage imageNamed:@"title.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0,30, 30);
    [backButton addTarget:self action:@selector(backButtonOnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.navigationItem.backBarButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"title.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)backButtonOnAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
