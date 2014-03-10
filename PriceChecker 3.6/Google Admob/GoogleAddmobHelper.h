//
//  GoogleAddmobHelper.h
//  SocialSweep
//
//  Created by Lets nurture on 11/02/14.
//  Copyright (c) 2014 letsnurture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADBannerView.h"
#import "GADInterstitial.h"

@interface GoogleAddmobHelper : NSObject <GADInterstitialDelegate>
//-------Addmob
@property (nonatomic,strong) GADBannerView *bannerView_;
//---------
-(void)AddGoogleAddmobToviewController:(UIViewController *)viewcontroller WithView: (UIView *)view;

//-------Full Screen Add
@property (nonatomic,strong) GADInterstitial *interstitial_;
-(void)MakeFullScreenAddReady;
-(void)AddFullScreenAddWithViewcontroller:(UIViewController *)controller;
@end
