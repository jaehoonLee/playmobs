//
//  UdidHelper.h
//  playmobsSDK
//
//  Created by Gpon on 4/29/13.
//  Copyright (c) 2013 lee jaehoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UdidHelper : NSObject
+ (NSString *)getMacAddress;
+ (NSString *)getHashedMacAddress;
@end
