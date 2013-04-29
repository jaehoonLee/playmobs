//
//  PlayMobsWebViewController.m
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import "PlayMobsWebViewController.h"
#import "SBJson.h"
#import "UdidHelper.h"

@interface PlayMobsWebViewController ()

@end

@implementation PlayMobsWebViewController

- (id)initWithAppID:(NSString *)appID userID:(NSString *)userID delegate:(id<PlaymobsClientDelegate>)delegate
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.frame = CGRectMake(0, 0, 320, 460);
        NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/publish/iphone?app=%@&id=%@", appID, userID];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        playMobsView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [playMobsView setDelegate:self];
        [playMobsView loadRequest:request];
        
        [self.view addSubview:playMobsView];
        
        _appID = appID;
        _delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//    NSLog(@"%@", [UdidHelper getHashedMacAddress]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
//    NSLog(@"%@\n%@", [webView.request.URL absoluteString], html);
    NSDictionary* dict = [[[SBJsonParser alloc] init] objectWithString:html];
    if ([[dict objectForKey:@"result"] isEqualToString:@"YES"])
    {
        BOOL app = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",[dict objectForKey:@"scheme"]]]]; //app
        if(app == NO)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict objectForKey:@"url"]]]; //appstore
        }
        else
        {
            NSLog(@"Request Success");
            NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/campaign/iphone/install"];
            NSURL * url = [NSURL URLWithString:urlStr];
            NSMutableURLRequest * requestPOST = [NSMutableURLRequest requestWithURL:url];
            [requestPOST setHTTPMethod:@"POST"];
            
            NSString *paramDataString =[NSString stringWithFormat:@"appid=%@&promotion_idx=%@&udid=%@", _appID, _promotion_idx, [UdidHelper getHashedMacAddress]];
            NSData *paramData = [paramDataString dataUsingEncoding:NSUTF8StringEncoding];
            [requestPOST setHTTPBody:paramData];
            
            [playMobsView loadRequest:requestPOST];
            [_delegate onComplete];
        }
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
//    NSLog(@"Test:%@\n%@", [webView.request.URL absoluteString], html);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSArray * urlArr = [request.URL.absoluteString componentsSeparatedByString:@"/"];
//    NSLog(@"TestTest:%@ %@", request.URL.absoluteString, [urlArr objectAtIndex:(urlArr.count - 2)]);
    
    
    if([[request.URL absoluteString] isEqualToString:@"http://playmobs.com/campaign/iphone/bridgeGoBack"])//뒤로가기 버튼
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    else if([[request.URL absoluteString] isEqualToString:@"itms-appss://itunes.apple.com/app/chrome/id535886823?mt=8"])//앱스토어 확인하는 부분.
    {
        NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/campaign/iphone/promotion_info"];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest * requestPOST = [NSMutableURLRequest requestWithURL:url];
        [requestPOST setHTTPMethod:@"POST"];

        NSString *paramDataString =[NSString stringWithFormat:@"appid=%@&promotion_idx=%@", _appID, _promotion_idx];
        NSData *paramData = [paramDataString dataUsingEncoding:NSUTF8StringEncoding];
        [requestPOST setHTTPBody:paramData];
        
        [playMobsView loadRequest:requestPOST];
        return NO;
    }
    else if([[urlArr objectAtIndex:(urlArr.count - 2)] isEqualToString:@"info_iphone"]) //해당 웹페이지로 들어갈 때 promotion_idx 저장해두기.
    {
        _promotion_idx = urlArr.lastObject;
    }
    
    return YES;
}

@end
