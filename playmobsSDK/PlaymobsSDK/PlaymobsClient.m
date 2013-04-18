//
//  PlaymobsClient.m
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import "PlaymobsClient.h"
#import "PlayMobsWebViewController.h"

@implementation PlaymobsClient
@synthesize delegate = _delegate;
- (id)initWithDelegate:(id)delegate appID:(NSString *)appID userID:(NSString *)userID
{
    self = [super init];
    if(self)
    {
        self.delegate = delegate;
        _appID = appID;
        _userID = userID;
    }
    return self;
}

- (void)initiate:(UIViewController *)playmobsView
{
    PlayMobsWebViewController * viewController = [[PlayMobsWebViewController alloc] initWithAppID:_appID userID:_userID];
    [viewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [viewController.view setBackgroundColor:[UIColor blackColor]];
    [playmobsView presentViewController:viewController animated:YES completion:^{
        NSLog(@"OnComplete");
    }];
}

- (void)onComplete
{
    NSLog(@"onComplete");
}
@end
