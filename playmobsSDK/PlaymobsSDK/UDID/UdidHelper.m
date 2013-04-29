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
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();
    
    int i;
    NSString *deviceIP = nil;
    NSString *mac = nil;
    for (i=0; i<MAXADDRS; ++i)
    {
        static unsigned long localHost = 0x7F000001;        // 127.0.0.1
        unsigned long theAddr;
        
        theAddr = ip_addrs[i];
        
        if (theAddr == 0) break;
        if (theAddr == localHost) continue;
        
//        NSLog(@"Name: %s MAC: %s IP: %s\n", if_names[i], hw_addrs[i], ip_names[i]);
        
        //decided what adapter you want details for
        if (strncmp(if_names[i], "en", 2) == 0)
        {
            NSLog(@"Adapter en has a IP of %s", ip_names[i]);
            mac = [NSString stringWithUTF8String:hw_addrs[i]];
            NSLog(@"%@", mac);
        }
    }
    
    return mac;
}

+ (NSString *)getHashedMacAddress
{
    return [[UdidHelper getMacAddress] MD5];
}
@end
