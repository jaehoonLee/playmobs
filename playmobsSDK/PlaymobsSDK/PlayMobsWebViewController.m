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
//    NSLog([webView.request.URL absoluteString]);
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
//    NSLog(html);
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

@end
