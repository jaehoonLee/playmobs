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
        playMobs = [[PlaymobsClient alloc] initWithDelegate:self appID:@"59080003" uID:@"00000001"];
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
    NSLog(@"OnComplete:%@",jsonDic);
    if([[jsonDic objectForKey:@"code"] isEqualToString:@"021"])
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"제목" message:[NSString stringWithFormat:@"실패하였습니다.[%@]", [jsonDic objectForKey:@"code"]]
                                                            delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alertView show];
//        [self dismissViewControllerAnimated:YES completion:nil];

    }
    else{
        NSString * pointStr = [NSString stringWithFormat:@"%@포인트가 지원되었습니다", [jsonDic objectForKey:@"point"]];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"제목" message:pointStr
                                                            delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alertView show];
//        [self dismissViewControllerAnimated:YES completion:nil];

    }
}

- (void)serviceStatusOnComplete:(NSDictionary *)jsonDic
{
    NSLog(@"%@", jsonDic);
}

#pragma mark - IBAction
- (IBAction)buttonOnClickAction
{
    [playMobs initiate];
}

- (IBAction)serviceStatusButtonOnClickAction
{
    [playMobs serviceStatus];
}


@end
