//
//  MostExpensiveVC.h
//  PriceChecker
//
//  Created by letsnurture on 1/20/14.
//  Copyright (c) 2014 LetsNurture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubCateDtlIPhoneVct.h"
#import "AppDelegate.h"
#import "MFSideMenu.h"

#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"

@class GAITrackedViewController;

@class SubCateDtlIPhoneVct;
@interface MostExpensiveVC : PullRefreshTableViewController<MBProgressHUDDelegate,ASIHTTPRequestDelegate>

@property (strong,nonatomic)ASIHTTPRequest *request;
// properties for UI controlls
@property (strong, nonatomic) IBOutlet UIImageView *imgBg;
@property (strong, nonatomic) IBOutlet UIImageView *imgBg_Blur;
@property (strong, nonatomic) IBOutlet UITableView *tblExpensive;

// loader indicator
@property (nonatomic, strong) MBProgressHUD *HUD;

// foram change
@property (nonatomic, strong) SubCateDtlIPhoneVct *scvc;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UIView *viewT;
@property (nonatomic, strong) NSString *StrApi,*responseString,*Str;
@property (nonatomic, strong) NSURL *url;
@end
