//
//  PlaymobsClient.m
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import "PlaymobsClient.h"
#import "SBJson.h"
#import "PlayMobsWebViewController.h"
#import "UdidHelper.h"

@implementation PlaymobsClient
@synthesize delegate = _delegate;
- (id)initWithDelegate:(id)delegate appID:(NSString *)appID uID:(NSString *)uID
{
    self = [super init];
    if(self)
    {
        self.delegate = delegate;
        _appID = appID;
        _userID = [UdidHelper getHashedMacAddress];
        _uID = uID;
    }
    return self;
}

//플레이몹스 웹페이지로 들어갑니다.
- (void)initiate
{
    UIViewController * parentViewController = (UIViewController *)self.delegate;
    PlayMobsWebViewController * viewController = [[PlayMobsWebViewController alloc] initWithAppID:_appID userID:_userID uID:_uID delegate:self.delegate];
    UINavigationController * navCon = [[UINavigationController alloc] initWithRootViewController:viewController];
    [navCon setNavigationBarHidden:YES];
    [viewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [viewController.view setBackgroundColor:[UIColor blackColor]];
    [parentViewController presentViewController:navCon animated:YES completion:^{
        
    }];
}

//서비스상태에 대해 요청합니다.
- (void)serviceStatus
{
    NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/campaign/iphone/serviceStatus"];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * requestPOST = [NSMutableURLRequest requestWithURL:url];
    [requestPOST setHTTPMethod:@"POST"];
    
    NSString *paramDataString =[NSString stringWithFormat:@"appid=%@", _appID];
    NSData *paramData = [paramDataString dataUsingEncoding:NSUTF8StringEncoding];
    [requestPOST setHTTPBody:paramData];
    
    [NSURLConnection connectionWithRequest:requestPOST delegate:self];
}


#pragma mark - NSURLConnectionDelegate
//서비스 상태에 대해 콜백을 받습니다.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary* dict = [[[SBJsonParser alloc] init] objectWithString:returnString];
    [_delegate serviceStatusOnComplete:dict];
}

@end
