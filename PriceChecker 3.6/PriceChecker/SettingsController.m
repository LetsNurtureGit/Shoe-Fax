//
//  SettingsController.m
//  PriceChecker
//
//  Created by Letsnurture on 11/02/14.
//  Copyright (c) 2014 LetsNurture. All rights reserved.
//

#import "SettingsController.h"

@interface SettingsController ()

@end

@implementation SettingsController

#pragma mark - Setup Menu bar buttons

- (void)setupMenuBarButtonItems
{
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0))
    {
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        
    }
    else
    {
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    }
    
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    }
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(rightSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    if ([appDelegate isIphone5])
    {
        [_imgBg_Blur setImage:[UIImage imageNamed:@"bg_blur.png"]];
    }
    else if([appDelegate isIphone])
    {
        [_imgBg_Blur setImage:[UIImage imageNamed:@"bg_blur.png"]];
    }
    else
    {
        [_imgBg_Blur setImage:[UIImage imageNamed:@"bg_blur_iPad.png"]];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    
    NSData *pngDataFetch = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngDataFetch];
    
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath:filePath] == NO)
    {
        if ([appDelegate isIphone5])
        {
            [_imgBg setImage:[UIImage imageNamed:@"Background_Img_Iphone5.png"]];
        }
        else if([appDelegate isIphone])
        {
            [_imgBg setImage:[UIImage imageNamed:@"Background_Img_Iphone.png"]];
        }
        else
        {
            [_imgBg setImage:[UIImage imageNamed:@"Background_Img_Ipad.png"]];
            [_imgBg_Blur setImage:[UIImage imageNamed:@"bg_blur_iPad.png"]];
        }
    }
    else
    {
        [_imgBg setImage:image];
    }
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Setting"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    // ------------------------------------------------------------------
    
    [self setupMenuBarButtonItems];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(-10, -8, 320, 20);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = @"Settings";
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(-47, -15, 30, 30)];
    [imgLogo setImage:[UIImage imageNamed:@"search_iphone.png"]];
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    [view addSubview:imgLogo];
    self.navigationItem.titleView = view;
    //
    label=nil;
    view=nil;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0))
    {
        _imgBg.frame=CGRectMake(_imgBg.frame.origin.x,_imgBg.frame.origin.y, _imgBg.frame.size.width,_imgBg.frame.size.height+20);
        _imgBg_Blur.frame=CGRectMake(_imgBg_Blur.frame.origin.x,_imgBg_Blur.frame.origin.y, _imgBg_Blur.frame.size.width,_imgBg_Blur.frame.size.height+20);
    }
    
    [_swtAds addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"showAds"])
    {
        [_swtAds setOn:YES animated:YES];
    }
    else
    {
        [_swtAds setOn:NO animated:YES];
    }
}

#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:
     ^{
         [self setupMenuBarButtonItems];
     }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

#pragma mark - Switch change method

- (IBAction)switchValueChanged:(UISwitch *)theSwitch
{
    BOOL state = [theSwitch isOn];
    
    if(state)
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"showAds"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"showAds"];
    }
    
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - Memory Warning Method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
