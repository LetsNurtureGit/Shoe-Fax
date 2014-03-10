//
//  RecentlyView.h
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 22/01/14.
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


@interface RecentlyView : PullRefreshTableViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,ASIHTTPRequestDelegate>
{}
@property (strong,nonatomic)ASIHTTPRequest *request;

// properties for UI controlls
@property (strong, nonatomic) IBOutlet UIImageView *imgBg;
@property (strong, nonatomic) IBOutlet UIImageView *imgBg_Blur;
//@property (strong, nonatomic) IBOutlet UITableView *tblExpensive;

// loader indicator
@property (nonatomic, strong) MBProgressHUD *HUD;


// foram change
@property (nonatomic, strong) SubCateDtlIPhoneVct *scvc;

// foram change
@property (nonatomic, strong) IBOutlet UITableView *TblRecently;
@property (nonatomic, strong) IBOutlet UITableViewCell *TblRecentlyCell;
@property (nonatomic, strong) IBOutlet UIImageView *imgProduct;
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) NSString *StrApi,*responseString,*Str;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UIView *viewT;

@end
