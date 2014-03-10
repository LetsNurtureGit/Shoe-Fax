//
//  SubCateDtlIPhoneVct.m
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 26/12/13.
//  Copyright (c) 2013 LetsNurture. All rights reserved.
//

#import "SubCateDtlIPhoneVct.h"
#import "GAI.h"
#import "DummyController.h"
#import "QuartzCore/QuartzCore.h"

#define kXDistance    5
#define kYDistance    5
#define kThumbWidth   70
#define kThumbHeight   75
#define kTagForImageView    10000


@interface SubCateDtlIPhoneVct ()

@end

@implementation SubCateDtlIPhoneVct
{}

@synthesize actionSheet;
@synthesize arrForDetails = _arrForDetails;
@synthesize ScrForImag = _ScrForImag;
@synthesize arForImages = _arForImages;
@synthesize scrPage = _scrPage;
@synthesize currentPage = _currentPage;


#pragma mark - Orientation Methods

- (BOOL)shouldAutorotate
{
    //make view landscape on start
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - Initialization of View

- (id)initWithNibName:(NSString *)nibName
               bundle:(NSBundle *)nibBundle
             category:(NSString *)category
{
    self = [super initWithNibName:nibName
                           bundle:nibBundle];
    if (self) {}
    return self;
}

#pragma mark - Custom Method

-(void) rotateController:(UIViewController *)controller degrees:(NSInteger)aDgrees
{
    UIScreen *screen = [UIScreen mainScreen];
    if(aDgrees>0)
        self.navigationController.view.bounds = CGRectMake(0, 0, screen.bounds.size.height, screen.bounds.size.width);
    else
    {
        self.navigationController.view.bounds = CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height);
    }
    self.navigationController.view.transform = CGAffineTransformConcat(self.navigationController.view.transform, CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(aDgrees)));
}

- (void)dispatch_Deatil
{
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [appDelegate.ghelper AddGoogleAddmobToviewController:self WithView:self.view];
    [_View_Menu sendSubviewToBack:appDelegate.ghelper.bannerView_];
    [self.view bringSubviewToFront:_View_Menu];

    if([appDelegate isIpad])
    {
        [_btnClose.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:25.0f]];
    }
    
    CALayer *layer = [_btnClose layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:0.2f];
    
    [super viewDidLoad];
    NSString *actionSheetTitle = @""; //Action Sheet Title
    // NSString *destructiveTitle = @"Destructive Button"; //Action Sheet Button Titles
    NSString *other1 = @"Kixify ";
    NSString *other2 = @"ebay";
    //  NSString *other3 = @"Other Button 3";
    NSString *cancelTitle = @"Cancel";
    
   actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2, nil];

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
//    
//    NSData *pngDataFetch = [NSData dataWithContentsOfFile:filePath];
//    UIImage *image = [UIImage imageWithData:pngDataFetch];
//    
//    NSFileManager* fileMgr = [NSFileManager defaultManager];
//    
//    if ([fileMgr fileExistsAtPath:filePath] == NO)
//    {
        if([appDelegate isIphone5])
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
//    }
//    else
//    {
//        [_imgBg setImage:image];
//    }
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Product Detail"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    [self showLoader];
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0))
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:self
                                                                                action:@selector(ClickBack)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow1"]
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:self
                                                                                action:@selector(ClickBack)];
    }
    
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0))
    {
        _imgBg.frame=CGRectMake(_imgBg.frame.origin.x,_imgBg.frame.origin.y, _imgBg.frame.size.width,_imgBg.frame.size.height+20);
        _imgBg_Blur.frame=CGRectMake(_imgBg_Blur.frame.origin.x,_imgBg_Blur.frame.origin.y, _imgBg_Blur.frame.size.width,_imgBg_Blur.frame.size.height+20);
    }
    
    
    self.ScrForImag.pagingEnabled=TRUE;
	self.ScrForImag.backgroundColor=[UIColor whiteColor];
    
    self.arForImages=[NSArray arrayWithObjects:@"ipro_img1.png",@"ipro_img2.png",@"ipro_img3.png",@"ipro_img4.png", nil];
    self.arForFullImages=[NSArray arrayWithObjects:@"imain_pro_01.png",@"imain_pro_02.png",@"imain_pro_03.png",@"imain_pro_04.png", nil];
}

-(void)viewDidAppear:(BOOL)animated
{}

- (void)viewWillAppear:(BOOL)animated
{
    [[_imgView layer]setMasksToBounds:YES];

    _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, self.view.frame.size.height+20, _View_Menu.frame.size.width, 205);

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
    
    _imgBg.image=IMG_placeholderImage;
    
    self.navigationController.navigationBar.translucent=YES;
    
    _label = [[UILabel alloc] init];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
            
            _label.frame = CGRectMake(0, 0, 235, 20);
        }
        else{
            _label.frame = CGRectMake(0, 0, 235, 20);

        }
    }
    else
    {
        if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0))
        {
            _label.frame = CGRectMake(0, 0, 660, 20);
        }
        else{
            _label.frame = CGRectMake(0, 0, 660, 20);
        }
    }

    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont boldSystemFontOfSize:16];
    _label.text = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"title"];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.adjustsFontSizeToFitWidth = YES;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 20)];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)
    {
        view.frame=CGRectMake(0, 0, 700, 20);
    }
    
    [view addSubview:_label];
    self.navigationItem.titleView = view;
    _label=nil;
    view=nil;
    
 	[super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - set Data to view

-(void)ShowData
{
    if ([[AppDelegate sharedInstance].dictSelected_Product count]!=0)
    {
        if ([[self removeNull:[NSString stringWithFormat:@"%@",[[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"price"]]] length]!=0)
        {
            
            NSArray *Array=[[NSString stringWithFormat:@"%@",[[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"price"]] componentsSeparatedByString:@","];
            
            float fAvg = [[NSString stringWithFormat:@"%@",[Array objectAtIndex:0]] floatValue];

            float fLow = fAvg - [[Array objectAtIndex:1] floatValue];
            float fHigh = fAvg + [[Array objectAtIndex:1] floatValue];
            
            [_lblLowest_Price setText:[NSString stringWithFormat:@"Low   :  $ %.2f",fLow]];

            [_lblAvg_Price setText:[NSString stringWithFormat:@"Average :  $ %.2f",fAvg]];

            [_lblHighest_Price setText:[NSString stringWithFormat:@"High  :  $ %.2f",fHigh]];
        }
        else
        {
            [_lblLowest_Price setText:[NSString stringWithFormat:@"Low   :  $ 0.00"]];
            
            [_lblAvg_Price setText:[NSString stringWithFormat:@"Average :  $ 0.00"]];
            
            [_lblHighest_Price setText:[NSString stringWithFormat:@"High  :  $ 0.00"]];
        }
    }
    else
    {
        [_lblLowest_Price setText:[NSString stringWithFormat:@"Low   :  $ 0.00"]];
        
        [_lblAvg_Price setText:[NSString stringWithFormat:@"Average :  $ 0.00"]];
        
        [_lblHighest_Price setText:[NSString stringWithFormat:@"High  :  $ 0.00"]];
    }
        // counting for lowest & highest price based on average price
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if (![[[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"large_img_iPhone"] isEqual:[NSNull null]])
            _str = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"large_img_iPhone"];
        else
            _str = @"";
    }
    else
    {
        if (![[[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"large_img"] isEqual:[NSNull null]])
            _str = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"large_img"];
        else
            _str = @"";
    }
    
    _str = [_str stringByReplacingOccurrencesOfString:@" " withString:@""];
    [_imgView setBackgroundColor:[UIColor clearColor]];

    [_imgView setImageWithURL:[NSURL URLWithString:_str] placeholderImage:[UIImage imageNamed:@"pro_img.png"]];
}

#pragma mark - Remove Null

-(NSString *)removeNull:(NSString *)str
{
    str = [NSString stringWithFormat:@"%@",str];
    if (!str) {
        return @"";
    }
    else if([str isEqualToString:@"<null>"]){
        return @"";
    }
    else if([str isEqualToString:@"(null)"]){
        return @"";
    }
    else{
        return str;
    }
}

#pragma mark - Loader Methods

-(void) showLoader
{
    _FlagWebserviceRun=0;
     _HUD.delegate = self;
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [self loadProduct];
}

UIAlertView *alert;

-(void)loadProduct
{
    // Check for internet connection
    
    if([appDelegate checkInternet])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [self loadReachability];
        return;
    }
    else
    {
        _strApi = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"id"];
        
        _request =[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LOAD_TRENDING_COUNTER,_strApi]]];
        
        _request.delegate=self;
        
        [_request startAsynchronous];
    }
}

-(void) showLoader1
{
    _FlagWebserviceRun=1;
    
    _HUD.delegate = self;
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [self loadProduct_Detail];
}

#pragma mark - ASIHttprequest Delegate Methods
- (void)requestFailed:(ASIHTTPRequest *)request
{
    alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Request Fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [self loadReachability];
    [self ShowData];
    
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    _responseString=[request responseString];
    
    if(_FlagWebserviceRun==0)
    {
        if ([[[[[_responseString JSONValue] objectForKey:@"data"] objectAtIndex:0]  lowercaseString] isEqualToString:@"success"]==NO) {
            alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax"message:@"Response Fail Please Try Again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Try Again",nil];
        }
        else
        {
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            [self showLoader1];
        }
    }
    else if(_FlagWebserviceRun==1)
    {
        _Array_Temp=[[NSMutableArray alloc] init];
        
        for (NSDictionary *User in [[_responseString JSONValue] objectForKey:@"img-data"])
        {
            [_Array_Temp addObject:User];
        }
        
        if ([_Array_Temp count]!=0)
        {
            if ([[[_responseString JSONValue] valueForKey:@"success"] integerValue]==0)
            {
                alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Data Not Found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [self loadReachability];
                [self ShowData];
                
            }
            else
            {
                [AppDelegate sharedInstance].dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[_Array_Temp objectAtIndex:0]];
                
                [self ShowData];
            }
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Data Not Found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [self loadReachability];
            [self ShowData];
        }
    }
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

#pragma mark - Fetch Product Detail

-(void)loadProduct_Detail
{
    if([appDelegate checkInternet])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [self loadReachability];
        return;
    }
    else
    {
        // Get Product Details
        
        _strId = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"id"];
        
        _request =[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LOAD_GET_DETAIL,_strId]]];
        
        _request.delegate=self;
        
        [_request startAsynchronous];
    }
}

-(void)loadReachability
{
    [alert show];
}

#pragma mark
#pragma mark button actions

-(void)ClickBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Click_Buy:(id)sender
{
    @try
    {
        if([appDelegate checkInternet])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [self loadReachability];
            return;
        }
        else
        {
            _Btn_History.userInteractionEnabled=FALSE;
            _Btn_Buy.userInteractionEnabled=FALSE;
            _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, self.view.frame.size.height+20, _View_Menu.frame.size.width, 205);
            
            [UIView beginAnimations:@"MoveView" context:nil];
            [UIView setAnimationDuration:0.5];
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                CGSize result = [[UIScreen mainScreen] bounds].size;
                
                if(result.height == 480)
                {
                    if (Flag_AdsBanner==1)
                    {
                        _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 237, _View_Menu.frame.size.width, 205);
                    }
                    else
                    {
                        _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 275, _View_Menu.frame.size.width, 205);
                    }
                    
//                    [actionSheet showInView:self.view];
                }
                else
                {
                    if (Flag_AdsBanner==1)
                    {
                        _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 310, _View_Menu.frame.size.width, 205);
                    }
                    else
                    {
                        _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 365, _View_Menu.frame.size.width, 205);
                    }
                   
                }
               
                
//                [actionSheet showInView:self.view];
            }
            else
            {
                [UIView beginAnimations:@"MoveView" context:nil];
                [UIView setAnimationDuration:0.5];
                if (Flag_AdsBanner==1)
                {
                    _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 730, _View_Menu.frame.size.width, 205);
                }
                else
                {
                    _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 810, _View_Menu.frame.size.width, 205);
                }
            }
            [UIView commitAnimations];
        }
    }
    @catch (NSException *exception)
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Warning!!" message:@"Try again!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    @finally
    {}
}

- (IBAction)goToUrl1:(id)sender
{
    NSString *str;
    str = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"title"];
    
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KIXIFY_URL,str]]];
}

- (IBAction)goToUrl2:(id)sender
{
    NSString *str;

    str = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"url_2"];
    
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]]];
}

- (IBAction)CloseView:(id)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 480)
        {
            if (Flag_AdsBanner==1)
            {
                _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 237, _View_Menu.frame.size.width, 205);
            }
            else{
                _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 275, _View_Menu.frame.size.width, 205);
            }
        }
        else
        {
            if (Flag_AdsBanner==1)
            {
                _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 310, _View_Menu.frame.size.width, 205);
            }
            else
            {
                _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 365, _View_Menu.frame.size.width, 205);
            }
        }
    }
    else
    {
        if (Flag_AdsBanner==1)
        {
            _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 730, _View_Menu.frame.size.width, 205);
        }
        else
        {
            _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, 829, _View_Menu.frame.size.width, 205);
        }
    }
    
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationDuration:0.5];
    _View_Menu.frame=CGRectMake(_View_Menu.frame.origin.x, self.view.frame.size.height+20, _View_Menu.frame.size.width, 205);
    [UIView commitAnimations];
    
    _Btn_History.userInteractionEnabled=TRUE;
    _Btn_Buy.userInteractionEnabled=TRUE;
}

- (IBAction)lowestClicked:(id)sender
{
    if([appDelegate checkInternet])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

        [self loadReachability];
        return;
    }
    else
    {
        WebViewVC *wvvc;
        
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if([appDelegate isIphone5])
                wvvc = [[WebViewVC alloc] initWithNibName:@"WebViewVC" bundle:nil];
            else
                wvvc = [[WebViewVC alloc] initWithNibName:@"WebViewVc_Iphone4" bundle:nil];
        }
        else if([appDelegate isIpad])
            wvvc = [[WebViewVC alloc] initWithNibName:@"WebView_iPad" bundle:nil];
        
        wvvc.dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[AppDelegate sharedInstance].dictSelected_Product];
        wvvc.isURLType = @"History";
        
        if ([self presentingViewController] != self)
        {
            [self presentViewController:wvvc animated:YES completion:nil];
        }
    }
}

- (IBAction)avgClicked:(id)sender
{
    if([appDelegate checkInternet])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

        [self loadReachability];
        return;
    }
    else
    {
        WebViewVC *wvvc;
        
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if([appDelegate isIphone5])
                wvvc = [[WebViewVC alloc] initWithNibName:@"WebViewVC" bundle:nil];
            else
                wvvc = [[WebViewVC alloc] initWithNibName:@"WebViewVc_Iphone4" bundle:nil];
        }
        else if([appDelegate isIpad])
            wvvc = [[WebViewVC alloc] initWithNibName:@"WebView_iPad" bundle:nil];
        
        wvvc.dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[AppDelegate sharedInstance].dictSelected_Product];
        wvvc.isURLType = @"History";
        
        if ([self presentingViewController] != self)
        {
            [self presentViewController:wvvc animated:YES completion:nil];
        }
    }
}

- (IBAction)highClicked:(id)sender
{
    if([appDelegate checkInternet])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

        [self loadReachability];
        return;
    }
    else
    {
        WebViewVC *wvvc;
        
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if([appDelegate isIphone5])
                wvvc = [[WebViewVC alloc] initWithNibName:@"WebViewVC" bundle:nil];
            else
                wvvc = [[WebViewVC alloc] initWithNibName:@"WebViewVc_Iphone4" bundle:nil];
        }
        else if([appDelegate isIpad])
            wvvc = [[WebViewVC alloc] initWithNibName:@"WebView_iPad" bundle:nil];
        
        wvvc.dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[AppDelegate sharedInstance].dictSelected_Product];
        wvvc.isURLType = @"History";
        
        if ([self presentingViewController] != self)
        {
            [self presentViewController:wvvc animated:YES completion:nil];
        }
    }
}
- (IBAction)HistoryClicked:(id)sender
{
    @try
    {
        if([appDelegate checkInternet])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [self loadReachability];
            return;
        }
        else
        {
            WebViewVC *wvvc;
            
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if([appDelegate isIphone5])
                    wvvc = [[WebViewVC alloc] initWithNibName:@"WebViewVC" bundle:nil];
                else
                    wvvc = [[WebViewVC alloc] initWithNibName:@"WebViewVc_Iphone4" bundle:nil];
            }
            else if([appDelegate isIpad])
                wvvc = [[WebViewVC alloc] initWithNibName:@"WebView_iPad" bundle:nil];
            
            wvvc.dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[AppDelegate sharedInstance].dictSelected_Product];
            wvvc.isURLType = @"History";
            
            if ([self presentingViewController] != self)
            {
                [self presentViewController:wvvc animated:YES completion:nil];
            }
        }
    }
    @catch (NSException *exception)
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Warning!!" message:@"Try again!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    @finally
    {}
}

#pragma mark - ActionSheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *str;
    
    if(buttonIndex==0)
    {
        str = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"title"];
        
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KIXIFY_URL,str]]];
    }
    else if(buttonIndex==1)
    {
        str = [[AppDelegate sharedInstance].dictSelected_Product valueForKey:@"url_2"];
        
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]]];
    }
}


#pragma mark
#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [self showLoader];
    }
}

#pragma mark
#pragma mark invoked functions

- (void)setupImages
{
    [[self.scrPage subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.scrPage.contentSize=CGSizeMake((self.arForImages.count)*90, 68);
    NSUInteger i=2;
    
    for (NSString *str in self.arForImages)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        if(i==2)
            [btn setFrame:CGRectMake(0, kYDistance , kThumbWidth, kThumbHeight)];
        else
            [btn setFrame:CGRectMake((i-2)*75, kYDistance, kThumbWidth, kThumbHeight)];
        
        btn.tag=i-1; // index tagging strating from 1
        
          [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchDown];
        
        [self.scrPage addSubview:btn];
        i++;
    }
    
    self.currentPage = 0;
}
- (void)btnTapped:(UIButton*)btn {
    self.scrPage.delegate=nil;
    CGRect rectToScroll = btn.frame;
    rectToScroll=CGRectMake(rectToScroll.origin.x-63-63, kYDistance, 320, 68);
    [self.scrPage scrollRectToVisible:rectToScroll animated:YES];
}

#pragma mark
#pragma mark scrollview delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger curPage = (scrollView.contentOffset.x - 5 ) / 63;
    
    if(curPage<0 || curPage>=self.arForImages.count) return;
    
    if(curPage!=self.currentPage)
    {
         self.currentPage=curPage;
    }
}

#pragma mark - Dealloc

-(void)dealloc
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    [_request cancel];
    _request.delegate=nil;
    _request=nil;
    
    if ([AppDelegate sharedInstance].dictSelected_Product!=nil) {
        [[AppDelegate sharedInstance].dictSelected_Product removeAllObjects];
        [AppDelegate sharedInstance].dictSelected_Product=nil;
    }
    
    _View_Menu=nil;
    _Btn_Buy=nil;
    _Btn_History=nil;
    
    actionSheet=nil;
    _arForImages=nil;
    _arForFullImages=nil;
    _scrPage=nil;
    _ScrForImag=nil;
    _arrForDetails=nil;
    _imgForDisplay=nil;
    
    // declare instance for UI controls
    _lblLowest_Price=nil;
    _lblAvg_Price=nil;
    _lblHighest_Price=nil;
    _imgView=nil;
    _imgBg=nil;
    _imgBg_Blur=nil;
    
    // foram change
    _label=nil;
    _str=nil;
    _strApi=nil;
    _responseString=nil;
    _strId=nil;
    [_Array_Temp removeAllObjects];
    _Array_Temp=nil;
}

#pragma mark - Memory Warning Methods

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
