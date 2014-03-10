//
//  constant.h
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 26/12/13.
//  Copyright (c) 2013 LetsNurture. All rights reserved.
//

#import "AppDelegate.h"

#define GoogleBannerSmallID @"ca-app-pub-2932090677554695/1988045161"

#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_IPOD   ( [[[UIDevice currentDevice ] model] isEqualToString:@"iPod touch"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )

#define GlobalCacheManager [(AppDelegate*)[[UIApplication sharedApplication] delegate] globalHJObj]
#define appDel (AppDelegate*)[[UIApplication sharedApplication] delegate]

#define DOCUMENTS_FOLDER [NSTemporaryDirectory() stringByAppendingPathComponent:@"/myTmp/"]

//#define LOAD_PRODUCT_URL @"http://letsnurture.co.uk/web-service/price-checker-app/index.php?allData=true"
//#define LOAD_BGIMAGE_URL @"http://letsnurture.co.uk/web-service/price-checker-app/images/index.php?allData=true"

//#define LOAD_PRODUCT_URL @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/index.php?allData=true"

#define DEFAULT_IMAGE_URL @"http://2.bp.blogspot.com/-1LzMQh1Uj2I/T88P1JYwAWI/AAAAAAAAHyA/036Q5XLd3-U/s1600/nike-air-yeezy-2-pure-platinum_07.jpg"

#define LOAD_PRODUCT_URL @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/pager.php?allData=true&page="

#define LOAD_SEARCH_PRODUCT_URL @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/search.php?keyword="

#define LOAD_BGIMAGE_URL @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/images/index.php?allData=true"
#define LOAD_EXPENSIVE @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/expensive.php?expensive=true&limit=10"

#define LOAD_TRENDING @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/trending.php?trend=true&limit=10"

#define LOAD_RECENTLY @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/recent.php?recent=true&limit=10"

#define LOAD_HISTORY @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/chart.php?tag="

#define LOAD_TRENDING_COUNTER @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/counter.php?id="

#define LOAD_GET_DETAIL @"http://ec2-54-200-146-26.us-west-2.compute.amazonaws.com/api/index.php?id="

#define MILLENNIAL_IPHONE_AD_VIEW_FRAME CGRectMake(0, 520, 320, 50)
#define MILLENNIAL_IPAD_AD_VIEW_FRAME CGRectMake(18, 940, 800, 90)
#define MILLENNIAL_AD_VIEW_FRAME ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? MILLENNIAL_IPAD_AD_VIEW_FRAME : MILLENNIAL_IPHONE_AD_VIEW_FRAME)

// Settings
#define CACHE_COUNT_LIMIT 200
#define FILE_AGE_LIMIT  60*60*24*7
#define PATH_OF_CACHE @""
#define AD_APPID @"148319"
#define KIXIFY_URL @"http://www.kixify.com/tag/"

int FlagLoadImage,FlagSlashScreen,Flag_AdsBanner,Flag_SelectedView,Flag_MenuVisible,Flag_orientation;

UIImage *IMG_placeholderImage;


