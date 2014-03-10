//
//  AppDelegate.m
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 25/12/13.
//  Copyright (c) 2013 LetsNurture. All rights reserved.
//

#import "AppDelegate.h"
#import "SplashVctrForiPhone.h"
#import "ViewController.h"
#import "MMSDK.h"
#import "SideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "GoogleAddmobHelper.h"


/******* Set your tracking ID here *******/
static NSString *const kTrackingId = @"UA-47462030-1";
static NSString *const kAllowTracking = @"allowTracking";
@interface AppDelegate ()

- (NSDictionary *)loadImages;

@end
@implementation AppDelegate

@synthesize isIpad,isIphone,isIphone5,sglobalorientation,container,ghelper;

- (NSDictionary *)loadImages
{
    NSArray *contents = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg"
                                                           inDirectory:nil];
    if (!contents) {
        NSLog(@"Failed to load directory contents");
        return nil;
    }
    NSMutableDictionary *images = [NSMutableDictionary dictionary];
    for (NSString *file in contents) {
        NSArray *components = [[file lastPathComponent]
                               componentsSeparatedByString:@"-"];
        if (components.count == 0) {
            NSLog(@"Filename doesn't contain dash: %@", file);
            continue;
        }
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        if (!image) {
            NSLog(@"Failed to load file: %@", file);
            continue;
        }
        NSString *prefix = components[0];
        NSMutableArray *categoryImages = images[prefix];
        if (!categoryImages) {
            categoryImages = [NSMutableArray array];
            images[prefix] = categoryImages;
        }
        [categoryImages addObject:image];
    }
    for (NSString *cat in [images allKeys]) {
        NSArray *array = images[cat];
        NSLog(@"Category %@: %u image(s).", cat, array.count);
    }
    return images;
}

#pragma mark - Google Analytics intialization

-(void)Load_GoogleAnalyltic
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    
    // Initialize tracker.
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
    
    [tracker set:kGAIScreenName value:@"Shoe Fax"];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

#pragma mark - Airship Intialization

-(void)Load_AirShip
{
    UAConfig *config = [UAConfig defaultConfig];
    
    // You can also programmatically override the plist values:
    // config.developmentAppKey = @"YourKey";
    // etc.
    
    // Call takeOff (which creates the UAirship singleton)
    [UAirship takeOff:config];
}

#pragma mark - Milenial ads

-(void)Show_MMAdsBanner
{
    //------- Ad View -----------
    
    //MMRequest Object
    MMRequest *request = [MMRequest requestWithLocation:[AppDelegate sharedInstance].locationManager.location];
    
    NSLog(@"%@",NSStringFromCGRect(MILLENNIAL_AD_VIEW_FRAME));
    // Replace YOUR_APID with the APID provided to you by Millennial Media
    
    
    if ([[UIScreen mainScreen ] bounds].size.height >= 568)
    {
        self.banner = [[MMAdView alloc] initWithFrame:MILLENNIAL_AD_VIEW_FRAME apid:AD_APPID
                              rootViewController:self.window.rootViewController];
    }
    else
    {
        self.banner = [[MMAdView alloc] initWithFrame:CGRectMake(0, 432, 320, 50) apid:AD_APPID
                              rootViewController:self.window.rootViewController];
    }
    self.banner.backgroundColor=[UIColor clearColor];

    [self.banner getAdWithRequest:request onCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"BANNER AD REQUEST SUCCEEDED");

            Flag_AdsBanner=1;
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Price_Set_SetTableViewSize"
             object:self];
            
            [self.window addSubview:self.banner];

        }
        else {
            Flag_AdsBanner=0;
            NSLog(@"BANNER AD REQUEST FAILED WITH ERROR: %@", error);
            // Check for internet connection
            Reachability* reachability = [Reachability reachabilityWithHostName:@"www.google.co.in"];
            NetworkStatus remote = [reachability currentReachabilityStatus];
            
            if(remote != NotReachable)
            {}
        }
    }];
}

-(void)SHOW_ADS
{
    [self.window addSubview:self.banner];
}

#pragma mark - Splash Screen

-(void)SlashScreen
{
    SplashVctrForiPhone *svfi;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        svfi = [[SplashVctrForiPhone alloc] initWithNibName:@"SplashVctrForiPhone" bundle:nil];
    else
        svfi = [[SplashVctrForiPhone alloc] initWithNibName:@"SplashVctrForiPad" bundle:nil];
    
    self.window.rootViewController=svfi;
    
    [self.window makeKeyAndVisible];
}

#pragma mark - Admob Sdk

- (void)showAdmobAdd
{
    self.ghelper = [[GoogleAddmobHelper alloc] init];
}

#pragma mark - Application Life Cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    _date = [NSDate date];
    
    _formattedDateString = [_dateFormatter stringFromDate:_date];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"ShowFAX_SearchDate"] length]==0 ) {
        
        [[NSUserDefaults standardUserDefaults] setObject:_formattedDateString forKey:@"ShowFAX_SearchDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"ShowFAX_MostExpensive"] length]==0 ) {
        
        [[NSUserDefaults standardUserDefaults] setObject:_formattedDateString forKey:@"ShowFAX_MostExpensive"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"ShowFAX_Trending"] length]==0 ) {
        
        [[NSUserDefaults standardUserDefaults] setObject:_formattedDateString forKey:@"ShowFAX_Trending"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"ShowFAX_Recently"] length]==0 ) {
        
        [[NSUserDefaults standardUserDefaults] setObject:_formattedDateString forKey:@"ShowFAX_Recently"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    FlagSlashScreen=0;
    
    isIpad=NO;
    isIphone=NO;
    isIphone5=NO;
    
    [self CheckDevice];
    [self showAdmobAdd];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = [_paths objectAtIndex:0];
	_documentsDirectory = [_documentsDirectory stringByAppendingPathComponent:@"images/"];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [MMSDK initialize]; //Initialize a Millennial Media session
    
    //Create a location manager for passing location data for conversion tracking and ad requests
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
//    [self Show_MMAdsBanner];
    
    [self performSelectorInBackground:@selector(Load_GoogleAnalyltic) withObject:nil];
    
    ViewController *vc;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    else
        vc = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    
    SideMenuViewController *leftMenuViewController = [[SideMenuViewController alloc] init];
    
    _navigationController1 =[[UINavigationController alloc] initWithRootViewController:vc];
    
    _navigationController1.navigationBar.backgroundColor=[UIColor blackColor];
    
    container = [MFSideMenuContainerViewController containerWithCenterViewController: _navigationController1 leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
    
    container.navigationController.navigationBar.backgroundColor=[UIColor blackColor];
    
    appDelegate.window.rootViewController=container;
    
    [appDelegate.window makeKeyAndVisible];
    
//    [self SlashScreen];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

UIAlertView *alert;
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    UA_LDEBUG(@"Application did become active.");
    
    // Set the icon badge to zero on resume (optional)
    [[UAPush shared] resetBadge];
}

#pragma mark - Notification Methods

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    UA_LINFO(@"Received remote notification (in appDelegate): %@", userInfo);
    
    // Optionally provide a delegate that will be used to handle notifications received while the app is running
    // [UAPush shared].pushNotificationDelegate = your custom push delegate class conforming to the UAPushNotificationDelegate protocol
    
    // Reset the badge after a push received (optional)
    [[UAPush shared] resetBadge];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    UA_LINFO(@"Received remote notification (in appDelegate): %@", userInfo);
    
    // Optionally provide a delegate that will be used to handle notifications received while the app is running
    // [UAPush shared].pushNotificationDelegate = your custom push delegate class conforming to the UAPushNotificationDelegate protocol
    
    // Reset the badge after a push is received in a active or inactive state
    if (application.applicationState != UIApplicationStateBackground) {
        [[UAPush shared] resetBadge];
    }
    
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
    NSLog(@"deviceToken: %@", devToken);
}

#pragma mark - Custom Method

- (BOOL)checkInternet
{
    Reachability* reachability = [Reachability reachabilityWithHostName:@"www.google.co.in"];
    NetworkStatus remote = [reachability currentReachabilityStatus];
    
    if(remote == NotReachable)
    {
        return YES;
    }
    else
        return NO;
}

- (void)CheckDevice
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if([UIScreen mainScreen].bounds.size.height == 568.0)
        {
            isIphone5=YES;
        }
        else
        {
            isIphone=YES;
        }
    }
    else
    {
        isIpad=YES;
    }
}

#pragma mark
#pragma mark class methods

+(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL
{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString: inString];
    NSRange range = NSMakeRange(0, [attrString length]);
	
    [attrString beginEditing];
    [attrString addAttribute:NSLinkAttributeName value:[aURL absoluteString] range:range];
	
    // make the text appear in blue
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
	
    // next make the text appear with an underline
    [attrString addAttribute:
	 NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:range];
	
    [attrString endEditing];
	
    return attrString;
}

#pragma mark - singlton

+(AppDelegate *)sharedInstance
{
    static AppDelegate *shared = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        shared = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    });
    
    return shared;
}

#pragma mark - invoked methods

#pragma mark - Loader Methods

-(void)loadReachability
{
    [alert show];
}

#pragma mark - load Dynamic Images

-(void)loadImages1
{
//    [self MainScreen];
}
@end
