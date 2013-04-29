//
//  PlayMobsWebViewController.h
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayMobsWebViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView * playMobsView;
    NSString * _appID;
    NSString * _promotion_idx;
}
- (id)initWithAppID:(NSString *)appID userID:(NSString *)userID;
@end
