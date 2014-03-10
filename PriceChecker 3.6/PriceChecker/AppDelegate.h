//
//  AppDelegate.h
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 25/12/13.
//  Copyright (c) 2013 LetsNurture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSDK.h"
#import <CoreLocation/CoreLocation.h>
#import "MMAdView.h"
#import "UAirship.h"
#import "UAConfig.h"
#import "UAPush.h"
#import "GAI.h"
#import "GAIFields.h"
#import "MFSideMenuContainerViewController.h"
#import "GoogleAddmobHelper.h"
//#import "Crittercism.h"\



@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    
}
@property (nonatomic,strong)GoogleAddmobHelper *ghelper;

@property (nonatomic,strong)MFSideMenuContainerViewController *container;
@property (nonatomic,strong)NSString *sglobalorientation;
@property(nonatomic, strong)MMAdView *banner;

@property (readwrite)BOOL isIphone5,isIphone,isIpad;
@property(nonatomic, strong) id<GAITracker> tracker;
@property(nonatomic, strong) NSDictionary *images;

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UINavigationController *navCtrl;
@property(nonatomic,retain)UIViewController *viewController;
@property (strong, nonatomic) CLLocationManager *locationManager;

// an array instance to store the content
@property (nonatomic, strong) NSMutableArray *arrContent,*arrBg_image;

// an instance for the database
//@property (nonatomic, strong) SKDatabase *skdb;

// an instance to store the result
@property (nonatomic, strong) NSMutableArray *arrExpensive;

// declare a dictionary to store the selected value
@property (nonatomic, strong) NSMutableDictionary *dictSelected_Product;

// an instance to store the result
@property (nonatomic, strong) NSMutableArray *arrTrending;

// an instance to store the result
@property (nonatomic, strong) NSMutableArray *arrRecently;

// foram change
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *formattedDateString; 
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSArray *paths;
@property (nonatomic, strong) UINavigationController *navigationController1;

// ---------class methods------------

// singleton method
+(AppDelegate *)sharedInstance;
-(void)SlashScreen;
+(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL;
-(void)SHOW_ADS;

- (void)CheckDevice;
- (BOOL)checkInternet;
@end
