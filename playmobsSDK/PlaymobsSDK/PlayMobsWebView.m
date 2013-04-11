//
//  PlayMobsWebView.m
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import "PlayMobsWebView.h"

@implementation PlayMobsWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSURL * url = [NSURL URLWithString:@"http://playmobs.com/publish/iphone?app=59080003&id=99999999"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [self loadRequest:request];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
