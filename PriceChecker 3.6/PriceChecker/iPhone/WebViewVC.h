//
//  WebViewVC.h
//  PriceChecker
//
//  Created by letsnurture on 1/2/14.
//  Copyright (c) 2014 LetsNurture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "constant.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface WebViewVC : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>
{
    // foram change
//    int FlagStartPage;
}

// declare a dictionary to store the selected value

@property (nonatomic,strong)IBOutlet UILabel *lblTitle;
@property (nonatomic,strong)IBOutlet UIImageView *imgView;
@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) NSMutableDictionary *dictSelected_Product;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *isURLType;

// foram change
@property (assign) int FlagStartPage;

@end
