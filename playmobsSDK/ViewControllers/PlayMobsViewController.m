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
- (void)onComplete:(NSDictionary *)jsonDic
{
    NSLog(@"OnComplete");
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"제목" message:@"100만포인트가 지원되었습니다" delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil];
    [alertView show];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBAction
- (IBAction)buttonOnClickAction
{
    //    PlayMobsWebView * webView = [[PlayMobsWebView alloc] initWithFrame:CGRectMake(50, 50, 200, 300)];
    //    [self.view addSubview:webView];
    [playMobs initiate];
}

@end
