
#import "Trending.h"

@interface Trending ()

@end

@implementation Trending

#pragma mark - UIView LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
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
    _TblTrending.scrollsToTop=YES;
}

- (void)viewDidLoad
{
    [appDelegate.ghelper AddGoogleAddmobToviewController:self WithView:self.view];

    [super viewDidLoad];
    
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
    
    if ([AppDelegate sharedInstance].arrTrending!=nil)
    {
        [[AppDelegate sharedInstance].arrTrending removeAllObjects];
        [AppDelegate sharedInstance].arrTrending=nil;
    }
    
    [AppDelegate sharedInstance].arrTrending=[[NSMutableArray alloc]init];
    

    
    // Google analytic Set Screen Name  ----------------------------------
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Trending"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    // ------------------------------------------------------------------
    
    [_TblTrending addSubview:refreshHeaderView];
    
    [self setupMenuBarButtonItems];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(-10, -10, 320, 20);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = @"Trending";
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(-50, -15, 30, 30)];
    [imgLogo setImage:[UIImage imageNamed:@"trending_iphone.png"]];
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    [view addSubview:imgLogo];
    self.navigationItem.titleView = view;
    
    label=nil;
    view=nil;
    
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
    
    // Do any additional setup after loading the view from its nib.
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
        _imgBg.frame=CGRectMake(_imgBg.frame.origin.x,_imgBg.frame.origin.y, _imgBg.frame.size.width,_imgBg.frame.size.height+20);
        _imgBg_Blur.frame=CGRectMake(_imgBg_Blur.frame.origin.x,_imgBg_Blur.frame.origin.y, _imgBg_Blur.frame.size.width,_imgBg_Blur.frame.size.height+20);
        _TblTrending.frame=CGRectMake(_TblTrending.frame.origin.x,_TblTrending.frame.origin.y, _TblTrending.frame.size.width,_TblTrending.frame.size.height+20);
    }
    
    if (Flag_AdsBanner==1) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            _TblTrending.frame=CGRectMake(_TblTrending.frame.origin.x,_TblTrending.frame.origin.y, _TblTrending.frame.size.width,_TblTrending.frame.size.height-50);
        }
        else{
            _TblTrending.frame=CGRectMake(_TblTrending.frame.origin.x,_TblTrending.frame.origin.y, _TblTrending.frame.size.width,_TblTrending.frame.size.height-90);
            
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
     
        [self loadReachability];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        return;
    }
    else
    {
        _StrApi = [LOAD_TRENDING stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        _StrApi = [_StrApi stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSURL *url = [NSURL URLWithString:[_StrApi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

        _request=[[ASIHTTPRequest alloc]initWithURL:url];
        
        _request.delegate=self;
        
        [_request startAsynchronous];
        
        NSLog(@"Str :%@",_StrApi);
     
    }
}

#pragma mark - ASIHttprequest Delegate

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[AppDelegate sharedInstance].arrExpensive removeAllObjects];
    alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Request Fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
   
    [self loadReachability];
    [_TblTrending reloadData];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    _responseString=[request responseString];
    
    [[AppDelegate sharedInstance].arrTrending removeAllObjects];

    for (NSDictionary *User in [[_responseString JSONValue] objectForKey:@"data"])
    {
        [[AppDelegate sharedInstance].arrTrending addObject:User];
    }
    
    if ([[AppDelegate sharedInstance].arrTrending count]!=0) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
        
        
        NSDate *date = [NSDate date];
        
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:formattedDateString forKey:@"ShowFAX_Trending"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        [_TblTrending reloadData];
        
    }
    else
    {
        [[AppDelegate sharedInstance].arrTrending removeAllObjects];
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Data Not Found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      
        [self loadReachability];
        [_TblTrending reloadData];
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

#pragma mark - Custom Method

-(void)loadReachability
{
    [alert show];
}

-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [_TblTrending setContentOffset:CGPointZero animated:YES];
    return YES;
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
    return [[AppDelegate sharedInstance].arrTrending count];
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
        [[NSBundle mainBundle]loadNibNamed:@"TrendingCell" owner:self options:nil];
        cell=_TblTrendingCell;
        
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
        
        if (![[[[AppDelegate sharedInstance].arrTrending objectAtIndex:indexPath.row] valueForKey:@"title"] isEqual:[NSNull null]])
            _lblTitle.text = [NSString stringWithFormat:@"%d. %@",indexPath.row+1,[[[AppDelegate sharedInstance].arrTrending objectAtIndex:indexPath.row] valueForKey:@"title"]];
        else
            _lblTitle.text = @"NA";
        
        NSString *str;
        
        if (![[[[AppDelegate sharedInstance].arrTrending objectAtIndex:indexPath.row] valueForKey:@"image_url"] isEqual:[NSNull null]] )
        {
            str = [[[AppDelegate sharedInstance].arrTrending objectAtIndex:indexPath.row] valueForKey:@"image_url"];
            
            str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
         
        }
        else
            str = DEFAULT_IMAGE_URL;
        
        [_imgProduct setImageWithURL:[NSURL URLWithString:DEFAULT_IMAGE_URL]
                   placeholderImage:[UIImage imageNamed:@"pro_img_spotlight.png"]
                            options:0];
        
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
    
    if ([AppDelegate sharedInstance].dictSelected_Product!=nil) {
        [[AppDelegate sharedInstance].dictSelected_Product removeAllObjects];
        [AppDelegate sharedInstance].dictSelected_Product=nil;
    }
    [AppDelegate sharedInstance].dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[[AppDelegate sharedInstance].arrTrending objectAtIndex:indexPath.row]];
    
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

- (void)startLoading
{
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        _TblTrending.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;

       _Str=[NSString stringWithFormat:@"%@\nLast Updated: %@",refreshLabel.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"ShowFAX_Trending"]];
        
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
        _TblTrending.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                  
                         [self stopLoadingComplete];
                     }];
}

#pragma mark - Scroll View Delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoading)
    {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            _TblTrending.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            _TblTrending.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
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

#pragma mark - alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    
}

#pragma mark - Dealloc

-(void)dealloc
{
    if (Flag_SelectedView!=2) {
        if (_request!=nil) {
            [_request cancel];
            _request.delegate=nil;
            _request=nil;
        }
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        
        if ([AppDelegate sharedInstance].arrTrending!=nil) {
            [[AppDelegate sharedInstance].arrTrending removeAllObjects];
            [AppDelegate sharedInstance].arrTrending=nil;
            
        }
        
    }
    
    // properties for UI controlls
    _imgBg=nil;
    _imgBg_Blur=nil;
    
    // loader indicator
    _HUD=nil;
    
    // foram change
    _scvc=nil;
    
    // foram change
    _TblTrending=nil;
    _TblTrendingCell=nil;
    _imgProduct=nil;
    _lblTitle=nil;
    _StrApi=nil;
    _responseString=nil;
    _Str=nil;
    
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
