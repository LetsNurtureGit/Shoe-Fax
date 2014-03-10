//
//  ViewController.h
//  TableSearch
//
//  Created by Jobin Kurian on 10/02/12.
//  Copyright (c) 2012 Fafadia Tech, Mumbai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubCateDtlIPhoneVct.h"

#import "SplashVctrForiPhone.h"
#import "MFSideMenu.h"

#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"

@class GAITrackedViewController;

@interface ViewController : PullRefreshTableViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate,MBProgressHUDDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,ASIHTTPRequestDelegate>
{
    // foram change
//    int CurrentPage,TotalPage;
//    int Flag_CallWebservice,Lenth_SearchBartext;
//    UIView *headerView;
    
}
@property (strong,nonatomic)IBOutlet UILabel *Lbl_Results;

@property (strong,nonatomic)ASIHTTPRequest *request;
@property (strong, nonatomic)UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UITableView *tblContentList;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (assign) BOOL isSearching;
@property (nonatomic, strong) SubCateDtlIPhoneVct *scvc;

// properties for UI controlls
@property (strong, nonatomic) IBOutlet UIImageView *imgBg;
@property (strong, nonatomic) IBOutlet UIImageView *imgBg_Blur;


// foram change
@property (nonatomic, strong) UITapGestureRecognizer *anyTouch;
@property (nonatomic, strong) UITapGestureRecognizer *anyTouch1;

// foram change
@property (assign)int CurrentPage,TotalPage,Flag_CallWebservice,Lenth_SearchBartext,TotalRecord;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSString *str,*StrApi,*responseString;

@end
