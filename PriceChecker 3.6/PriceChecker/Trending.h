//
//  Trending.h
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

@interface Trending : PullRefreshTableViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,ASIHTTPRequestDelegate>
{
    // foram change
//    IBOutlet UITableView *TblTrending;
//    IBOutlet UITableViewCell *TblTrendingCell;
//    IBOutlet UIImageView *imgProduct;
//    IBOutlet UILabel *lblTitle;

}
@property (strong,nonatomic)ASIHTTPRequest *request;

// properties for UI controlls
@property (strong, nonatomic) IBOutlet UIImageView *imgBg;
@property (strong, nonatomic) IBOutlet UIImageView *imgBg_Blur;

// loader indicator
@property (nonatomic, strong) MBProgressHUD *HUD;

// foram change
@property (nonatomic, strong) SubCateDtlIPhoneVct *scvc;

// foram change
@property (nonatomic, strong) IBOutlet UITableView *TblTrending;
@property (nonatomic, strong) IBOutlet UITableViewCell *TblTrendingCell;
@property (nonatomic, strong) IBOutlet UIImageView *imgProduct;
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) NSString *StrApi,*responseString,*Str;
@end
