//
//  PlayMobsViewController.m
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import "PlayMobsViewController.h"

@interface PlayMobsViewController ()

@end

@implementation PlayMobsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        playMobs = [[PlaymobsClient alloc] initWithDelegate:self appID:@"59080003" userID:@"00000009"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - PlaymobsClientDelegate
- (void)onComplete
{
    
    
}

#pragma mark - IBAction
- (IBAction)buttonOnClickAction
{
    //    PlayMobsWebView * webView = [[PlayMobsWebView alloc] initWithFrame:CGRectMake(50, 50, 200, 300)];
    //    [self.view addSubview:webView];
    [playMobs initiate];
}

@end
