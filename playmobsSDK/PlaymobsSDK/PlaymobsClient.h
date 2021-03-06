//
//  PlaymobsClient.h
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PlaymobsClientDelegate <NSObject>
@required
- (void)onComplete:(NSDictionary *)jsonDic;
- (void)serviceStatusOnComplete:(NSDictionary*)jsonDic;
@end

@interface PlaymobsClient : NSObject <NSURLConnectionDataDelegate>
{
    id<PlaymobsClientDelegate> _delegate;
    NSString * _appID;
    NSString * _userID;
    NSString * _uID;
}
- (id)initWithDelegate:(id)delegate appID:(NSString *)appID uID:(NSString *)uID;
- (void)initiate;
- (void)serviceStatus;
@property(nonatomic, strong) id<PlaymobsClientDelegate> delegate;
@end
