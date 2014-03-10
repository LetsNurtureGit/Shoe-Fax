//
//  SplashVctrForiPhone.m
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 25/12/13.
//  Copyright (c) 2013 LetsNurture. All rights reserved.
//

#import "SplashVctrForiPhone.h"

@interface SplashVctrForiPhone ()

@end

@implementation SplashVctrForiPhone
{}

#pragma mark
#pragma mark view life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([appDelegate isIphone5])
    {
        [_imgBgBlur setImage:[UIImage imageNamed:@"bg_blur_logo_960.png"]];
    }
    else if([appDelegate isIphone])
    {
        [_imgBgBlur setImage:[UIImage imageNamed:@"bg_blur_logo.png"]];
    }
    else
    {
        [_imgBgBlur setImage:[UIImage imageNamed:@"bg_blur_logo_iPad.png"]];
    }

    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent=YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(FinishToLoadImage)
                                                 name:@"Price_FinishLoadimge"
                                               object:nil];
    FlagLoadImage=0;
    [self saveImage];

    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
        _imgBg.frame=CGRectMake(_imgBg.frame.origin.x,_imgBg.frame.origin.y, _imgBg.frame.size.width,_imgBg.frame.size.height+20);
        _imgBgBlur.frame=CGRectMake(_imgBgBlur.frame.origin.x,_imgBgBlur.frame.origin.y, _imgBgBlur.frame.size.width,_imgBgBlur.frame.size.height+20);
    }

    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar.layer removeAllAnimations];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor],
          NSForegroundColorAttributeName,
          [UIFont boldSystemFontOfSize:18.0],
          NSFontAttributeName,
          nil]];
    }
    else
    {
    }
    [[[self navigationController] navigationBar] setNeedsLayout];
}

#pragma mark - fetch the image and save in simulator to be accessible globally

-(void)FinishToLoadImage
{
    sleep(1.0f);
    [self showHomePage1];
}

-(void)showHomePage1
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(showHomePage) userInfo:nil repeats:NO];
}

-(void)SHOWADS1
{
    [[AppDelegate sharedInstance] SHOW_ADS];
}

-(void)saveImage
{
    NSData *responseData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:LOAD_BGIMAGE_URL]];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    [AppDelegate sharedInstance].arrBg_image = [[NSMutableArray alloc] initWithArray:[[responseString JSONValue] objectForKey:@"img-data"]];
    
    IMG_placeholderImage=[[UIImage alloc] init];
    
    NSString *Str1;
    
    if([appDelegate isIphone] || [appDelegate isIphone5])
    {
         Str1=[[[AppDelegate sharedInstance].arrBg_image objectAtIndex:0]valueForKey:@"img_iphone_5"];
    }
    else
    {
         Str1=[[[AppDelegate sharedInstance].arrBg_image objectAtIndex:0]valueForKey:@"img_ipad_portrait"];
    }
    
    NSURL *url=[[NSURL alloc]initWithString:Str1];
    
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc]initWithURL:url];
    
    request.delegate=self;
    
    [request startSynchronous];
    
    IMG_placeholderImage=_imgBg.image;
    
    if([appDelegate isIphone5])
    {
        IMG_placeholderImage=[UIImage imageNamed:@"Background_Img_Iphone5.png"];
    }
    else if([appDelegate isIphone])
    {
        IMG_placeholderImage=[UIImage imageNamed:@"Background_Img_Iphone.png"];
    }
    else
    {
        IMG_placeholderImage=[UIImage imageNamed:@"Background_Img_Ipad.png"];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[[AppDelegate sharedInstance] arrBg_image] count] > 0)
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
            }
        }
        else
        {
            [self FinishToLoadImage];
        }
    }
    else
    {
        if ([[[AppDelegate sharedInstance] arrBg_image] count] > 0)
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
            }
        }
        else
        {
            [self FinishToLoadImage];
        }
    }
}

#pragma mark - ASIHttpRequest Delegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    imgData=[request responseData];
    
    [self FinishToLoadImage];
}

-(void)showHomePage
{
    // get the path to write the file into
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    [imgData writeToFile:filePath atomically:YES]; //Write the file
    
    NSLog(@"TIME >> %@\ndownload >> %@",[NSDate date],filePath);
    
    IMG_placeholderImage=[[UIImage alloc] init];
    
    IMG_placeholderImage=_imgBg.image;
    
    
    NSLog(@"ROHIT");
    [[AppDelegate sharedInstance] SHOW_ADS];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    ViewController *vc;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    else
        vc = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    
    SideMenuViewController *leftMenuViewController = [[SideMenuViewController alloc] init];
    
    UINavigationController *_navigationController1 =[[UINavigationController alloc] initWithRootViewController:vc];
    
    _navigationController1.navigationBar.backgroundColor=[UIColor blackColor];
    
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController containerWithCenterViewController: _navigationController1 leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
    
    container.navigationController.navigationBar.backgroundColor=[UIColor blackColor];
    
    appDelegate.window.rootViewController=container;
    
    [appDelegate.window makeKeyAndVisible];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
