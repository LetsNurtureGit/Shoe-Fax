//
//  SplashVctrForiPhone.h
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 25/12/13.
//  Copyright (c) 2013 LetsNurture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "constant.h"
#import "Trending.h"
#import "RecentlyView.h"
#import "MostExpensiveVC.h"
#import "AppDelegate.h"

@interface SplashVctrForiPhone : UIViewController
{
    NSData *imgData;
}
// declare an instance for UIViewController
@property(nonatomic,retain)UIViewController *viewController;

// assign properties for ui controls
@property (strong, nonatomic) IBOutlet UIImageView *imgBg,*imgBgBlur;


@end
