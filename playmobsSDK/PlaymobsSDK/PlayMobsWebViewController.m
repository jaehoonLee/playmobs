//
//  PlayMobsWebViewController.m
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import "PlayMobsWebViewController.h"
#import "SBJson.h"

@interface PlayMobsWebViewController ()

@end

@implementation PlayMobsWebViewController

- (id)initWithAppID:(NSString *)appID userID:(NSString *)userID
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    NSLog(@"%@\n%@", [webView.request.URL absoluteString], html);
    NSDictionary* dict = [[[SBJsonParser alloc] init] objectWithString:html];
    if ([[dict objectForKey:@"result"] isEqualToString:@"YES"])
    {
        BOOL app = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",[dict objectForKey:@"scheme"]]]]; //app
        if(app == NO)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict objectForKey:@"url"]]]; //appstore
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
    NSLog(@"TestTest:%@ %@", request.URL.absoluteString, [urlArr objectAtIndex:(urlArr.count - 2)]);
    
    if([[request.URL absoluteString] isEqualToString:@"http://playmobs.com/campaign/iphone/bridgeGoBack"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }else if([[request.URL absoluteString] isEqualToString:@"itms-appss://itunes.apple.com/app/chrome/id535886823?mt=8"])
    {
//        NSString * promotion_idx =[request.URL.absoluteString componentsSeparatedByString:@"/"].lastObject;
        NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/campaign/iphone/promotion_info"];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest * requestPOST = [NSMutableURLRequest requestWithURL:url];
        [requestPOST setHTTPMethod:@"POST"];

        NSString *paramDataString =[NSString stringWithFormat:@"appid=%@&promotion_idx=%@", _appID, _promotion_idx];
        NSData *paramData = [paramDataString dataUsingEncoding:NSUTF8StringEncoding];
        [requestPOST setHTTPBody:paramData];
        
        [playMobsView loadRequest:requestPOST];
        
//        BOOL app = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"googlechrome://"]]; //app
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-appss://itunes.apple.com/app/chrome/id535886823?mt=8"]]; //appstore
        return NO;
    }else if([[urlArr objectAtIndex:(urlArr.count - 2)] isEqualToString:@"info_iphone"])
    {
        _promotion_idx = urlArr.lastObject;
    }

//    NSString * parseStr = @"{\"id\":\"Hello\", \"wow\":\"male\"}";
//    NSDictionary* dict = [[[SBJsonParser alloc] init] objectWithString:parseStr];
    
    return YES;
}

@end
