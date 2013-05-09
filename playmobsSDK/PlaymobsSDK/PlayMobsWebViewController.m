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
//플레이몹스 웹페이지 생성자
- (id)initWithAppID:(NSString *)appID userID:(NSString *)userID uID:(NSString *)uID delegate:(id<PlaymobsClientDelegate>)delegate
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.frame = CGRectMake(0, 0, 320, 460);
        NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/publish/iphone?app=%@&id=%@&uid=%@", appID, userID, uID];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        playMobsView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [playMobsView setDelegate:self];
        [playMobsView loadRequest:request];
        
        [self.view addSubview:playMobsView];
        
        _appID = appID;
        _userID = userID;
        _uID = uID;
        _delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate
//웹페이지 request 중간에 호출됩니다.
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSArray * urlArr = [request.URL.absoluteString componentsSeparatedByString:@"/"];
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    
    if([[request.URL absoluteString] isEqualToString:@"http://playmobs.com/campaign/iphone/bridgeGoBack"])//뒤로가기 버튼
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    else if([[request.URL absoluteString] isEqualToString:@"http://playmobs.com/campaign/iphone/store"])//앱스토어 확인하는 부분.
    {
        NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/campaign/iphone/promotion_info"];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest * requestPOST = [NSMutableURLRequest requestWithURL:url];
        [requestPOST setHTTPMethod:@"POST"];

        NSString *paramDataString =[NSString stringWithFormat:@"appid=%@&promotion_idx=%@&id=%@", _appID, _promotion_idx, _userID];
        NSData *paramData = [paramDataString dataUsingEncoding:NSUTF8StringEncoding];
        [requestPOST setHTTPBody:paramData];
        
        [NSURLConnection connectionWithRequest:requestPOST delegate:self];
        NSLog(@"StoreCheck");
        return NO;
    }
    else if([[urlArr objectAtIndex:(urlArr.count - 2)] isEqualToString:@"info_iphone"]) //해당 웹페이지로 들어갈 때 promotion_idx 저장해두기.
    {
        _promotion_idx = urlArr.lastObject;
    }
    else if([[urlArr objectAtIndex:(urlArr.count - 2)] isEqualToString:@"fail"]) //인스톨 확인 실패시 호출
    {
        NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/publish/iphone?app=%@&id=%@", _appID, _userID];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSURLRequest * requestGET = [NSURLRequest requestWithURL:url];
        
        [playMobsView loadRequest:requestGET];
        
        NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
        [result setObject:[urlArr objectAtIndex:(urlArr.count - 1)] forKey:@"code"];
        [_delegate onComplete:result];
        return NO;
    }
    
    return YES;
}

#pragma mark - NSURLConnectionDelegate
//POST Request 요청시 콜백으로 받습니다.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"returnString:%@", returnString);
    NSDictionary* dict = [[[SBJsonParser alloc] init] objectWithString:returnString];
    if ([[dict objectForKey:@"method"] isEqualToString:@"request"])
    {
        BOOL app = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",[dict objectForKey:@"scheme"]]]]; //app
        if(app == NO)
        {
            NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/publish/info_iphone/%@", _promotion_idx];
            NSURL * url = [NSURL URLWithString:urlStr];
            NSMutableURLRequest * requestGET = [NSMutableURLRequest requestWithURL:url];
            
            [playMobsView loadRequest:requestGET];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict objectForKey:@"url"]]]; //appstore
        }
        else
        {
//            [playMobsView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
            NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/campaign/iphone/install"];
            NSURL * url = [NSURL URLWithString:urlStr];
            NSMutableURLRequest * requestPOST = [NSMutableURLRequest requestWithURL:url];
            [requestPOST setHTTPMethod:@"POST"];
            
            NSString *paramDataString =[NSString stringWithFormat:@"appid=%@&promotion_idx=%@&id=%@&uid=%@", _appID, _promotion_idx, _userID, _uID];
            NSData *paramData = [paramDataString dataUsingEncoding:NSUTF8StringEncoding];
            [requestPOST setHTTPBody:paramData];
            
            [NSURLConnection connectionWithRequest:requestPOST delegate:self];
        }
        
    }
    else if([[dict objectForKey:@"method"] isEqualToString:@"complete"])
    {
        NSString* urlStr = [NSString stringWithFormat:@"http://playmobs.com/publish/iphone?app=%@&id=%@", _appID, _userID];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSURLRequest * requestGET = [NSURLRequest requestWithURL:url];

        [playMobsView loadRequest:requestGET];
        [_delegate onComplete:dict];
    }
}
@end
