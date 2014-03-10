//
//  WebViewVC.m
//  PriceChecker
//
//  Created by letsnurture on 1/2/14.
//  Copyright (c) 2014 LetsNurture. All rights reserved.
//

#import "WebViewVC.h"
#import "DummyController.h"

@interface WebViewVC ()

@end

@implementation WebViewVC

#pragma mark - Intialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [_webView stopLoading];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_webView setDelegate:nil];
    [_webView stopLoading];
}

-(void)viewWillAppear:(BOOL)animated
{
    _lblTitle.text= [_dictSelected_Product valueForKey:@"title"];
    
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
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
        
    }
    if (Flag_AdsBanner==1)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
        }
        else
        {
        }
    }
    
    [[self view] removeGestureRecognizer:[UIGestureRecognizer new]];
    
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    self.navigationController.navigationBar.translucent=YES;
    
    UILabel *label = [[UILabel alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
            
            label.frame = CGRectMake(0, 0, 235, 20);
        }
        else{
            label.frame = CGRectMake(0, 0, 235, 20);
            
        }
    }
    else{
        if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
            
            label.frame = CGRectMake(0, 0, 660, 20);
        }
        else
        {
            label.frame = CGRectMake(0, 0, 660, 20);
        }
    }
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = [_dictSelected_Product valueForKey:@"title"];
    label.textAlignment=NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(150, 0, 320, 20);
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont boldSystemFontOfSize:16];
    label1.text = @"Search";
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(-80, -15, 30, 30)];
    [imgLogo setImage:[UIImage imageNamed:@"search_iphone.png"]];
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label1];
    [view addSubview:imgLogo];
    self.navigationItem.titleView = view;
    
    NSString *str = [_dictSelected_Product valueForKey:@"id"];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    NSLog(@"converted >> %@",str);
    
    if ([_isURLType isEqualToString:@"Kixify"])
    {
        NSLog(@"%@%@",KIXIFY_URL,str);
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KIXIFY_URL,str]]]];
    }
    else if ([_isURLType isEqualToString:@"eBay"])
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_dictSelected_Product valueForKey:@"url_2"]]]];
    else if ([_isURLType isEqualToString:@"Low"])
    {
        NSLog(@"%@%@?order=low",KIXIFY_URL,str);
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?order=low",KIXIFY_URL,str]]]];
    }
    else if ([_isURLType isEqualToString:@"Avg"])
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KIXIFY_URL,str]]]];
    }
    else if ([_isURLType isEqualToString:@"High"])
    {
        NSLog(@"%@%@?order=high",KIXIFY_URL,str);
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?order=high",KIXIFY_URL,str]]]];
    }
    else if ([_isURLType isEqualToString:@"History"])
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",LOAD_HISTORY,str]);
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LOAD_HISTORY,str]]]];
    }
}

#pragma mark - Button Click Method

- (IBAction)btnBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Orientation Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||     interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (BOOL)shouldAutorotate
{
    //make view landscape on start
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
   return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

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

#pragma mark - Custom Method

- (void)enableInteraction
{
    [[UIApplication sharedApplication]endIgnoringInteractionEvents];
}

-(void)ClickBack
{
    Flag_orientation=1;
    [self.navigationController  popViewControllerAnimated:YES];
}

#pragma mark - Webview delegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (_FlagStartPage==0)
    {
        _FlagStartPage=1;
        
        _HUD.delegate = self;
        
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

-(void)webView:(id)view didStartProvisionalLoadForFrame:(id)frame
{
    
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Dealloc

-(void)dealloc
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    _webView=nil;
}

@end
