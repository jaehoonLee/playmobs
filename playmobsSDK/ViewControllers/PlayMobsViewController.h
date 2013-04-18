//
//  PlayMobsViewController.h
//  playmobsSDK
//
//  Created by lee jaehoon on 13. 4. 11..
//  Copyright (c) 2013년 lee jaehoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaymobsClient.h"
@interface PlayMobsViewController : UIViewController
{
    PlaymobsClient * playMobs;
    
}
- (IBAction)buttonOnClickAction;
@end
