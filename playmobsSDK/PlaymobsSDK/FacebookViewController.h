//
//  FacebookViewController.h
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 6. 3..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookViewController : UIViewController
{
      UIWebView * facebookView;
}
- (id)initWithURL:(NSString *)urlStr;
@end
