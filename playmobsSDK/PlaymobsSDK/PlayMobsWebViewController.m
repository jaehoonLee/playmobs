//
//  PlayMobsWebViewController.m
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import "PlayMobsWebViewController.h"

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
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    NSLog(@"Test:%@\n%@", [webView.request.URL absoluteString], html);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"TestTest:%@", request.URL.absoluteString);
    if([[request.URL absoluteString] isEqualToString:@"http://playmobs.com/campaign/iphone/bridgeGoBack"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }else if([[request.URL absoluteString] isEqualToString:@"http"])
    {
        
        BOOL app = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"googlechrome://"]]; //app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-appss://itunes.apple.com/app/chrome/id535886823?mt=8"]]; //appstore
    }

    
    return YES;
}

@end
