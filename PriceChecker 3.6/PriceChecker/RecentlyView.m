//
//  RecentlyView.m
//  PriceChecker
//
//  Created by LetsNurture-Mac-Mini on 22/01/14.
//  Copyright (c) 2014 LetsNurture. All rights reserved.
//

#import "RecentlyView.h"

@interface RecentlyView ()

@end

@implementation RecentlyView

#pragma mark - UIView LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
}

-(void)viewWillAppear:(BOOL)animated
{
    [self showLoader];

    _TblRecently.scrollsToTop=YES;
}

- (void)viewDidLoad
{
    [appDelegate.ghelper AddGoogleAddmobToviewController:self WithView:self.view];

    [super viewDidLoad];
    
    if ([AppDelegate sharedInstance].arrRecently!=nil) {
        [[AppDelegate sharedInstance].arrRecently removeAllObjects];
        [AppDelegate sharedInstance].arrRecently=nil;
        
    }
    
    [AppDelegate sharedInstance].arrRecently=[[NSMutableArray alloc]init];
    
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
    // Google analytic Set Screen Name  ----------------------------------
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Recently Added"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    // ------------------------------------------------------------------
    
    [_TblRecently addSubview:refreshHeaderView];
    
    
    [self setupMenuBarButtonItems];
    [appDelegate CheckDevice];
    
    
    
    _label  = [[UILabel alloc] init];
    
    _label.frame = CGRectMake(-40, -10, 320, 20);
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont boldSystemFontOfSize:16];
    _label.text = @"Recently Added";
    
    _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(-80, -15, 30, 30)];
    [_imgLogo setImage:[UIImage imageNamed:@"recent_added_iPhone.png"]];
    
    _viewT = [[UIView alloc] init];
    [_viewT addSubview:_label];
    [_viewT addSubview:_imgLogo];
    self.navigationItem.titleView = _viewT;
    
    _label=nil;
    _imgLogo=nil;
    _viewT=nil;
    // Do any additional setup after loading the view from its nib.
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
//    
//    NSData *pngDataFetch = [NSData dataWithContentsOfFile:filePath];
//    UIImage *image = [UIImage imageWithData:pngDataFetch];
//    
//    NSFileManager* fileMgr = [NSFileManager defaultManager];
    
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
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
        _imgBg.frame=CGRectMake(_imgBg.frame.origin.x,_imgBg.frame.origin.y, _imgBg.frame.size.width,_imgBg.frame.size.height+20);
        _imgBg_Blur.frame=CGRectMake(_imgBg_Blur.frame.origin.x,_imgBg_Blur.frame.origin.y, _imgBg_Blur.frame.size.width,_imgBg_Blur.frame.size.height+20);
        _TblRecently.frame=CGRectMake(_TblRecently.frame.origin.x,_TblRecently.frame.origin.y, _TblRecently.frame.size.width,_TblRecently.frame.size.height+20);
    }
    if (Flag_AdsBanner==1)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            _TblRecently.frame=CGRectMake(_TblRecently.frame.origin.x,_TblRecently.frame.origin.y, _TblRecently.frame.size.width,_TblRecently.frame.size.height-50);
        }
        else{
            _TblRecently.frame=CGRectMake(_TblRecently.frame.origin.x,_TblRecently.frame.origin.y, _TblRecently.frame.size.width,_TblRecently.frame.size.height-90);
            
        }
    }
    
    // Do any additional setup after loading the view from its nib.
}

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
    if([appDelegate checkInternet])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self loadReachability];
        return;
    }
    else
    {
        _StrApi = [LOAD_RECENTLY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        _StrApi = [_StrApi stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        _url = [NSURL URLWithString:[_StrApi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        _request=[[ASIHTTPRequest alloc]initWithURL:_url];
        
        _request.delegate=self;
        
        [_request startAsynchronous];
        
        
       
    }
}

#pragma mark - ASIHttprequest Method

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[AppDelegate sharedInstance].arrExpensive removeAllObjects];
    alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Request Fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [self loadReachability];
    [_TblRecently reloadData];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    _responseString=[request responseString];
    
    [[AppDelegate sharedInstance].arrRecently removeAllObjects];

    
    for (NSDictionary *User in [[_responseString JSONValue] objectForKey:@"data"])
    {
        [[AppDelegate sharedInstance].arrRecently addObject:User];
    }
    
    if ([[AppDelegate sharedInstance].arrRecently count]!=0) {
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
        
        
        NSDate *date = [NSDate date];
        
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:formattedDateString forKey:@"ShowFAX_Recently"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [_TblRecently reloadData];
        
    }
    else
    {
        [[AppDelegate sharedInstance].arrTrending removeAllObjects];
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Data Not Found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      
        [self loadReachability];
        [_TblRecently reloadData];
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - Custom Methods

-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [_TblRecently setContentOffset:CGPointZero animated:YES];
    return YES;
}

-(void)loadReachability
{
    [alert show];
}

#pragma mark Table view

#pragma mark ----  data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AppDelegate sharedInstance].arrRecently count];
}

- (void)tableView:(UITableView *)tableView1  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView1 setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell ==nil)
    {
        [[NSBundle mainBundle]loadNibNamed:@"RecentlyViewCell" owner:self options:nil];
        cell=_TblRecentlyCell;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            _lblTitle.frame = CGRectMake(65, 5, 230, 21);
            _imgProduct.frame=CGRectMake(10, 0, 45, 30);
            _imgProduct.layer.cornerRadius=5;
        }
        else
        {
            _lblTitle.frame = CGRectMake(120, 20, 537, 42);
            [_lblTitle setFont:[UIFont boldSystemFontOfSize:20.0]];
            
            _imgProduct.frame=CGRectMake(10, 10, 90, 60);
            _imgProduct.layer.cornerRadius=10;
        }
        
        _lblTitle.lineBreakMode=NSLineBreakByCharWrapping;
        _lblTitle.numberOfLines=0;
        _imgProduct.layer.masksToBounds=YES;
        
        if (![[[[AppDelegate sharedInstance].arrRecently objectAtIndex:indexPath.row] valueForKey:@"title"] isEqual:[NSNull null]])
            _lblTitle.text = [NSString stringWithFormat:@"%d. %@",indexPath.row+1,[[[AppDelegate sharedInstance].arrRecently objectAtIndex:indexPath.row] valueForKey:@"title"]];
        else
            _lblTitle.text = @"NA";
        
        NSString *str;
        if (![[[[AppDelegate sharedInstance].arrRecently objectAtIndex:indexPath.row] valueForKey:@"image_url"] isEqual:[NSNull null]] )
        {
            str = [[[AppDelegate sharedInstance].arrRecently objectAtIndex:indexPath.row] valueForKey:@"image_url"];
            str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        else
            str = DEFAULT_IMAGE_URL;
        
        [_imgProduct setImageWithURL:[NSURL URLWithString:str]
                   placeholderImage:[UIImage imageNamed:@"pro_img_spotlight.png"]
                            options:SDWebImageRefreshCached];
        _lblTitle=nil;
        _imgProduct=nil;
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

    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen ] bounds].size.height >= 568)
            _scvc = [[SubCateDtlIPhoneVct alloc]initWithNibName:@"SubCateDtlIPhoneVct" bundle:nil];
        else
            _scvc = [[SubCateDtlIPhoneVct alloc]initWithNibName:@"catDetail" bundle:nil];
    }
    else
        _scvc = [[SubCateDtlIPhoneVct alloc]initWithNibName:@"SubCateDtlIPhoneVct_iPad" bundle:nil];
    
    [AppDelegate sharedInstance].dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[[AppDelegate sharedInstance].arrRecently objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:_scvc animated:YES];
}

#pragma mark - ScrollView Delgates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoading)
    {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            _TblRecently.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            _TblRecently.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
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

- (void)startLoading
{
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        _TblRecently.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        
        _Str=[NSString stringWithFormat:@"%@\nLast Updated: %@",refreshLabel.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"ShowFAX_Recently"]];

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
        _TblRecently.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished)
    {
                         [self stopLoadingComplete];
                     }];
}

#pragma mark - Dealloc

-(void)dealloc
{
    
    if (Flag_SelectedView!=1) {
        if (_request!=nil) {
            [_request cancel];
            _request.delegate=nil;
            _request=nil;
        }
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if ([AppDelegate sharedInstance].arrRecently!=nil) {
            [[AppDelegate sharedInstance].arrRecently removeAllObjects];
            [AppDelegate sharedInstance].arrRecently=nil;
            
        }
        
    }
    _imgBg=nil;
    _imgBg_Blur=nil;
    
    // loader indicator
    _HUD=nil;
    
    // foram change
    _scvc=nil;
    
    // foram change
    _TblRecently=nil;
    _TblRecentlyCell=nil;
    _imgProduct=nil;
    _lblTitle=nil;
    _StrApi=nil;
    _responseString=nil;
    _Str=nil;
    
}

#pragma mark - alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
