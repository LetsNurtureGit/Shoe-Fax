//
//  MostExpensiveVC.m
//  PriceChecker
//
//  Created by letsnurture on 1/20/14.
//  Copyright (c) 2014 LetsNurture. All rights reserved.
//

#import "MostExpensiveVC.h"

#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
@interface MostExpensiveVC ()

@end

@implementation MostExpensiveVC
{}
#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems
{
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


#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

#pragma mark
#pragma mark view life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       
        // self.screenName=@"Product Detail";

    }
    return self;
}
-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [_tblExpensive setContentOffset:CGPointZero animated:YES];
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
}
-(void)dealloc
{
    if (Flag_SelectedView!=1) {
        if (_request!=nil) {
            [_request cancel];
            _request.delegate=nil;
            _request=nil;
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([AppDelegate sharedInstance].arrExpensive!=nil) {
            [[AppDelegate sharedInstance].arrExpensive removeAllObjects];
            [AppDelegate sharedInstance].arrExpensive=nil;
            
        }
    }
    
    // properties for UI controlls
    _imgBg=nil;
    _imgBg_Blur=nil;
    _tblExpensive=nil;
    
    // loader indicator
    _HUD=nil;
    
        _scvc=nil;
    _label=nil;
    _imgLogo=nil;
    _viewT=nil;
    _StrApi=nil;
    _responseString=nil;
    _Str=nil;
    _url=nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    _tblExpensive.scrollsToTop=YES;

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

    [self showLoader];
}
- (void)viewDidLoad
{
    [appDelegate.ghelper AddGoogleAddmobToviewController:self WithView:self.view];

    [super viewDidLoad];
    
    if ([AppDelegate sharedInstance].arrExpensive!=nil) {
        [[AppDelegate sharedInstance].arrExpensive removeAllObjects];
        [AppDelegate sharedInstance].arrExpensive=nil;
        
    }
    [AppDelegate sharedInstance].arrExpensive=[[NSMutableArray alloc]init];
    
    // Google analytic Set Screen Name  ----------------------------------
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Most Expensive"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    // ------------------------------------------------------------------
    
    [_tblExpensive addSubview:refreshHeaderView];
    
    [self setupMenuBarButtonItems];

    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(-40, -10, 320, 20);
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont boldSystemFontOfSize:16];
    _label.text = @"Most Expensive";
    
    _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(-80, -15, 30, 30)];
    [_imgLogo setImage:[UIImage imageNamed:@"expensive_iphone.png"]];
    
    _viewT = [[UIView alloc] init];
    [_viewT addSubview:_label];
    [_viewT addSubview:_imgLogo];
    self.navigationItem.titleView = _viewT;
    
    _label=nil;
    _imgLogo=nil;
    _viewT=nil;
    // Do any additional setup after loading the view from its nib.
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
        _imgBg.frame=CGRectMake(_imgBg.frame.origin.x,_imgBg.frame.origin.y, _imgBg.frame.size.width,_imgBg.frame.size.height+20);
        _imgBg_Blur.frame=CGRectMake(_imgBg_Blur.frame.origin.x,_imgBg_Blur.frame.origin.y, _imgBg_Blur.frame.size.width,_imgBg_Blur.frame.size.height+20);
        _tblExpensive.frame=CGRectMake(_tblExpensive.frame.origin.x,_tblExpensive.frame.origin.y, _tblExpensive.frame.size.width,_tblExpensive.frame.size.height+20);
        
        
    }
    if (Flag_AdsBanner==1) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            _tblExpensive.frame=CGRectMake(_tblExpensive.frame.origin.x,_tblExpensive.frame.origin.y, _tblExpensive.frame.size.width,_tblExpensive.frame.size.height-50);
        }
        else{
            _tblExpensive.frame=CGRectMake(_tblExpensive.frame.origin.x,_tblExpensive.frame.origin.y, _tblExpensive.frame.size.width,_tblExpensive.frame.size.height-90);
            
        }

        
    }
   
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark
#pragma mark invoked functions

#pragma mark - Loader Methods

-(void) showLoader
{
    _HUD.delegate = self;

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadProduct];
}

UIAlertView *alert;

-(void)loadProduct
{
    // Check for internet connection
    
    if([appDelegate checkInternet])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self loadReachability];
        return;
    }
    else
    {
        _StrApi = [LOAD_EXPENSIVE stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _StrApi = [_StrApi stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        _url = [NSURL URLWithString:[_StrApi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        _request=[[ASIHTTPRequest alloc]initWithURL:_url];
        
        _request.delegate=self;
        
        [_request startAsynchronous];
        
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[AppDelegate sharedInstance].arrExpensive removeAllObjects];
    alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Request Fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
       [self loadReachability];
    [_tblExpensive reloadData];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    _responseString=[request responseString];
    
    [[AppDelegate sharedInstance].arrExpensive removeAllObjects];

    
    for (NSDictionary *User in [[_responseString JSONValue] objectForKey:@"data"])
    {
        [[AppDelegate sharedInstance].arrExpensive addObject:User];
    }
    
    if ([[AppDelegate sharedInstance].arrExpensive count]!=0)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
        
        NSDate *date = [NSDate date];
        
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
        
        [[NSUserDefaults standardUserDefaults] setObject:formattedDateString forKey:@"ShowFAX_MostExpensive"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [_tblExpensive reloadData];
    }
    else
    {
        [[AppDelegate sharedInstance].arrExpensive removeAllObjects];
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Data Not Found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
       
        [self loadReachability];
        [_tblExpensive reloadData];
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
-(void)loadReachability
{
    [alert show];
}

#pragma mark
#pragma mark Table view

#pragma mark ----  data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AppDelegate sharedInstance].arrExpensive count];
}

- (void)tableView:(UITableView *)tableView1  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView1 setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UILabel *lblTitle = [[UILabel alloc] init];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            lblTitle.frame = CGRectMake(65, 5, 230, 21);
            [lblTitle setFont:[UIFont boldSystemFontOfSize:15.0]];
        }
        else
        {
            lblTitle.frame = CGRectMake(120, 20, 537, 42);
            [lblTitle setFont:[UIFont boldSystemFontOfSize:20.0]];
        }
        
        lblTitle.lineBreakMode=NSLineBreakByCharWrapping;
        lblTitle.numberOfLines=0;
        [cell.contentView addSubview:lblTitle];
        
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [lblTitle setTextColor:[UIColor whiteColor]];
        
        UIImageView *imgProduct;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 45, 30)];
            imgProduct.layer.cornerRadius=5;
        }
        else
        {
            imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 60)];
            imgProduct.layer.cornerRadius=10;
        }
        
        [cell.contentView addSubview:imgProduct];
        imgProduct.layer.masksToBounds=YES;
        [imgProduct setBackgroundColor:[UIColor clearColor]];
        
        if (![[[[AppDelegate sharedInstance].arrExpensive objectAtIndex:indexPath.row] valueForKey:@"title"] isEqual:[NSNull null]])
            lblTitle.text = [NSString stringWithFormat:@"%d. %@",indexPath.row+1,[[[AppDelegate sharedInstance].arrExpensive objectAtIndex:indexPath.row] valueForKey:@"title"]];
        else
            lblTitle.text = @"NA";
        
        NSString *str;
        
        if (![[[[AppDelegate sharedInstance].arrExpensive objectAtIndex:indexPath.row] valueForKey:@"image_url"] isEqual:[NSNull null]] )
        {
            str = [[[AppDelegate sharedInstance].arrExpensive objectAtIndex:indexPath.row] valueForKey:@"image_url"];
            
            str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        else
            str = DEFAULT_IMAGE_URL;
        
//        str=DEFAULT_IMAGE_URL;
        
        [imgProduct setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"pro_img_spotlight.png"]];
        
        lblTitle=nil;
        imgProduct=nil;
    }

    return cell;
}


#pragma mark ----  delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return 60;
    else
        return 80;
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Product Detail Page"
                                            action:@"Button Press Product Detail"
                                             label:@"Product Detail"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];


    
//    SubCateDtlIPhoneVct *scvc;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen ] bounds].size.height >= 568)
            _scvc = [[SubCateDtlIPhoneVct alloc]initWithNibName:@"SubCateDtlIPhoneVct" bundle:nil category:@"Product Detail"];
        else
            _scvc = [[SubCateDtlIPhoneVct alloc]initWithNibName:@"catDetail" bundle:nil];
    }
    else
        _scvc = [[SubCateDtlIPhoneVct alloc]initWithNibName:@"SubCateDtlIPhoneVct_iPad" bundle:nil];
    
    if ([AppDelegate sharedInstance].dictSelected_Product!=nil) {
        [[AppDelegate sharedInstance].dictSelected_Product removeAllObjects];
        [AppDelegate sharedInstance].dictSelected_Product=nil;
    }
    [AppDelegate sharedInstance].dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[[AppDelegate sharedInstance].arrExpensive objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:_scvc animated:YES];
    
}
#pragma mark
#pragma mark PullDownToRefresh Customisation

- (void)refresh
{
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem
{
    [self loadProduct];
    
    [self stopLoading];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        if (isLoading)
        {
            // Update the content inset, good for section headers
            if (scrollView.contentOffset.y > 0)
                _tblExpensive.contentInset = UIEdgeInsetsZero;
            else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
                _tblExpensive.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (isDragging && scrollView.contentOffset.y < 0)
        {
            // Update the arrow direction and label
            [UIView animateWithDuration:0.25 animations:^{
                if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT)
                {
                    // User is scrolling above the header
                    refreshLabel.text = self.textRelease;
                    [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
                }
                else
                {
                    // User is scrolling somewhere within the header
                    refreshLabel.text = self.textPull;
                    [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
                }
            }];
        }
}

- (void)startLoading
{
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        _tblExpensive.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
         _Str=[NSString stringWithFormat:@"%@\nLast Updated: %@",refreshLabel.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"ShowFAX_MostExpensive"]];

        
        refreshLabel.text=[NSString stringWithFormat:@"%@",_Str];
        
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading
{
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        _tblExpensive.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished)
     {
         
         [self stopLoadingComplete];
     }];
}

#pragma mark
#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

}

@end
