//
//  GoogleAddmobHelper.m
//  SocialSweep
//
//  Created by Lets nurture on 11/02/14.
//  Copyright (c) 2014 letsnurture. All rights reserved.
//

#import "GoogleAddmobHelper.h"
#import "constant.h"
#import <CoreAudio/CoreAudioTypes.h> 

@implementation GoogleAddmobHelper
@synthesize bannerView_;
@synthesize interstitial_;
-(id)init
{
    self = [super init];
    return self;
}
-(void)AddGoogleAddmobToviewController:(UIViewController *)viewcontroller WithView: (UIView *)view
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSLog(@"Frame size %f",screenRect.size.height);
    
    if([UIScreen mainScreen].bounds.size.height==480 || [UIScreen mainScreen].bounds.size.height==568)
    {
         if (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0))
         {
             bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0, screenRect.size.height-GAD_SIZE_320x50.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
        }
        else
        {
            bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0, screenRect.size.height-(GAD_SIZE_320x50.height+20)+20, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
        }
    }
    else if([appDelegate isIpad])
    {
        if (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0))
        {
            bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(20.0f, screenRect.size.height-GAD_SIZE_728x90.height+10, GAD_SIZE_728x90.width, GAD_SIZE_728x90.height)];
        }
        else
        {
            bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(20.0f, screenRect.size.height-(GAD_SIZE_728x90.height+20)+20, GAD_SIZE_728x90.width, GAD_SIZE_728x90.height)];
        }
    }
//    bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0, screenRect.size.height-GAD_SIZE_320x50.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    
    //    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // Specify the ad unit ID.
    bannerView_.adUnitID = GoogleBannerSmallID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = viewcontroller;
    [view addSubview:bannerView_];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
    
    
//    GADRequest *request = [GADRequest request];
//    request.testing = YES;
//    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
//    
//    [bannerView_ loadRequest:request];
}
-(void)MakeFullScreenAddReady
{
    interstitial_ = [[GADInterstitial alloc] init];
//    interstitial_.adUnitID = GoogleFullScreenAdd;
    [interstitial_ loadRequest:[GADRequest request]];
}
-(void)AddFullScreenAddWithViewcontroller:(UIViewController *)controller
{
    [interstitial_ presentFromRootViewController:controller];
}

@end
