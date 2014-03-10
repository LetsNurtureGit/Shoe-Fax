//
//  SettingsController.h
//  PriceChecker
//
//  Created by Letsnurture on 11/02/14.
//  Copyright (c) 2014 LetsNurture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"

#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"

@interface SettingsController : UIViewController
{
    
}
@property (nonatomic,strong)IBOutlet UISwitch *swtAds;
@property (strong, nonatomic) IBOutlet UIImageView *imgBg;
@property (strong, nonatomic) IBOutlet UIImageView *imgBg_Blur;
@end
