//
//  SubCateDtlIPhoneVct.h
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 26/12/13.
//  Copyright (c) 2013 LetsNurture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WebViewVC.h"
//#import "UnderLineLabel.h"
#import "LBActionSheet.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "constant.h"
#import "ADTickerLabel.h"

//#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@interface SubCateDtlIPhoneVct : GAITrackedViewController<UIScrollViewDelegate,UIActionSheetDelegate,LBActionSheetDelegate,MBProgressHUDDelegate,ASIHTTPRequestDelegate,UIActionSheetDelegate>
{
    // foram change
//    int FlagWebserviceRun;
    
    UIActionSheet *actionSheet;

}
- (id)initWithNibName:(NSString *)nibName
               bundle:(NSBundle *)nibBundle
             category:(NSString *)category;


@property (nonatomic,strong)IBOutlet UIButton *btnClose;
@property (nonatomic,readwrite)int count;
@property (nonatomic,strong)NSMutableArray *arrTemp;

@property (strong,nonatomic)IBOutlet UIView *View_Menu;
@property (strong,nonatomic)IBOutlet UIButton *Btn_Buy;
@property (strong,nonatomic)IBOutlet UIButton *Btn_History;

@property (strong,nonatomic)ASIHTTPRequest *request;

@property (nonatomic,retain)UIActionSheet *actionSheet;
@property (nonatomic, strong) NSArray *arForImages;
@property (nonatomic, strong) NSArray *arForFullImages;
@property (nonatomic, strong) IBOutlet UIScrollView *scrPage;
@property (nonatomic, readwrite) NSUInteger currentPage;
@property(strong,nonatomic) IBOutlet UIScrollView *ScrForImag;
@property(strong,nonatomic) NSMutableArray *arrForDetails;
@property(nonatomic,retain)IBOutlet UIImageView *imgForDisplay;

// declare instance for UI controls
@property (strong, nonatomic) IBOutlet UILabel *lblLowest_Price,*lblAvg_Price,*lblHighest_Price;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIImageView *imgBg;
@property (strong, nonatomic) IBOutlet UIImageView *imgBg_Blur;


// foram change
@property (assign) int FlagWebserviceRun;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSString *str,*strApi,*responseString,*strId;
@property (nonatomic, strong) NSMutableArray *Array_Temp;

- (void)setupImages ;

// button actions
- (IBAction)goToUrl1:(id)sender;
- (IBAction)goToUrl2:(id)sender;
- (IBAction)lowestClicked:(id)sender;
- (IBAction)avgClicked:(id)sender;
- (IBAction)highClicked:(id)sender;
- (IBAction)HistoryClicked:(id)sender;
- (IBAction)Click_Buy:(id)sender;



@property (nonatomic, strong) MBProgressHUD *HUD;

@end
