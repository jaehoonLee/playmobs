//
//  UdidHelper.m
//  playmobsSDK
//
//  Created by Gpon on 4/29/13.
//  Copyright (c) 2013 lee jaehoon. All rights reserved.
//

#import "UdidHelper.h"
#import "IPAddress.h"
#import "NSStringMD5.h"


@implementation UdidHelper

+ (NSString *)getMacAddress
{
    char* macAddressString= (char*)malloc(18);
    NSString *macAddress= [[NSString alloc] initWithCString:getMacAddress(macAddressString,"en0") encoding:NSMacOSRomanStringEncoding];
    return macAddress;
}

+ (NSString *)getHashedMacAddress
{
    return [[self getMacAddress] MD5];
}

@end
