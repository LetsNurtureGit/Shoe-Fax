//
//  ViewController.m
//  TableSearch
//
//  Created by Jobin Kurian on 10/02/12.
//  Copyright (c) 2012 Fafadia Tech, Mumbai. All rights reserved.
//

#import "ViewController.h"
#import "MostExpensiveVC.h"

#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"

#define KTagTextTitle       1
#define KTagBACKIMAGE       2

@implementation ViewController
{}

@synthesize searchBar;
@synthesize searchBarController;

#pragma mark - Intialization of view

- (id)initWithNibName:(NSString *)nibName
               bundle:(NSBundle *)nibBundle
{
    self = [super initWithNibName:nibName
                           bundle:nibBundle];
    if (self)
    {}
    return self;
}

#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems
{
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0)) {
        
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [appDelegate.ghelper AddGoogleAddmobToviewController:self WithView:self.view];
//    [_View_Menu sendSubviewToBack:appDelegate.ghelper.bannerView_];
//    [self.view bringSubviewToFront:_View_Menu];
    
    searchBar.tintColor = [UIColor blackColor];
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
//    }
//    else
//    {
//        [_imgBg setImage:image];
//    }
    
    IMG_placeholderImage=[[UIImage alloc] init];
    
    IMG_placeholderImage=_imgBg.image;
    
    _activity= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        _activity.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
        _activity.frame = CGRectMake(130, 0, 50, 44);
    }
    else
    {
        _activity.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
        _activity.frame = CGRectMake(380, 0, 50, 44);
    }
    
    _Lbl_Results.text=@"";
    _Lbl_Results.hidden=TRUE;
    // Google analytic Set Screen Name  ----------------------------------
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Search Product"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    // ------------------------------------------------------------------
    
    [self setupMenuBarButtonItems];
    
    _CurrentPage=0;
    _TotalPage=0;
    if ([AppDelegate sharedInstance].arrContent!=nil) {
        [[AppDelegate sharedInstance].arrContent removeAllObjects];
        [AppDelegate sharedInstance].arrContent=nil;
        
    }
    [AppDelegate sharedInstance].arrContent = [[NSMutableArray alloc] init];
    
    
    [self _prepareNavigationbar];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Remove_Keyboard)
                                                 name:@"Price_Set_RemoveKeyboard"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SetTableViewSize)
                                                 name:@"Price_Set_SetTableViewSize"
                                               object:nil];
    
    self.navigationController.navigationBar.translucent=YES;
    
    [self showLoader];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(-10, -8, 320, 20);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = @"Search";
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(-47, -15, 30, 30)];
    [imgLogo setImage:[UIImage imageNamed:@"search_iphone.png"]];
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    [view addSubview:imgLogo];
    self.navigationItem.titleView = view;
    
    label=nil;
    view=nil;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {
        self.searchBar.tintColor=[UIColor clearColor];
        
        _imgBg.frame=CGRectMake(_imgBg.frame.origin.x,_imgBg.frame.origin.y, _imgBg.frame.size.width,_imgBg.frame.size.height+20);
        _imgBg_Blur.frame=CGRectMake(_imgBg_Blur.frame.origin.x,_imgBg_Blur.frame.origin.y, _imgBg_Blur.frame.size.width,_imgBg_Blur.frame.size.height+20);
        _tblContentList.frame=CGRectMake(_tblContentList.frame.origin.x,_tblContentList.frame.origin.y, _tblContentList.frame.size.width,_tblContentList.frame.size.height+20);
    }
    
    [self.searchBarController.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [_tblContentList addSubview:refreshHeaderView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
}

-(void)viewWillAppear:(BOOL)animated
{
    _tblContentList.scrollsToTop=YES;
}

- (void)viewDidUnload
{
    [self setTblContentList:nil];
    [self setSearchBar:nil];
    [self setSearchBarController:nil];
    [super viewDidUnload];
}

#pragma mark - Google Analytics Method

-(void)dispatch
{
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Product Detail Page"
                                            action:@"Button Press Product Detail"
                                             label:@"Product Detail"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
}

// Always drop the keyboard when the user taps on the table:
// This will correctly NOT affect any buttons in cell rows:

#pragma mark - Swipe Method

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");

    if(Flag_MenuVisible==0) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"Price_toggleMenuVisibility"
         object:self];
    }
}

-(void)handleSwipeFrom1:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");
    
        if(Flag_MenuVisible==1) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"Price_toggleMenuVisibility"
         object:self];
    }
}

#pragma mark - Rotation Method

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Custom Method

-(void)SetFlagValue
{
    _Flag_CallWebservice=0;
    
    if (isLoading==YES) {
        [self stopLoading];
    }
    
}
-(void)ReloadTable
{
    [_tblContentList reloadData];
}

-(void)loadReachability
{
    [alert show];
}

-(void)Remove_Keyboard
{
    _imgBg_Blur.hidden=TRUE;
    
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
    
    [self searchTableList];
}

-(void)navigationBarTap
{
    _imgBg_Blur.hidden=TRUE;
    
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
    
    if ([self.searchBar.text length]<3 && [self.searchBar.text length]>0) {
        self.searchBar.text=@"";
        _Lenth_SearchBartext=[self.searchBar.text length];
        
        _CurrentPage=0;
        _TotalPage=0;
        
        [[AppDelegate sharedInstance].arrContent removeAllObjects];
        
        [self showLoader];
    }
    else
    {
        if ([[AppDelegate sharedInstance].arrContent count]!=0)
        {
            _Lbl_Results.text=[NSString stringWithFormat:@"%d Results",_TotalRecord];
            _Lbl_Results.hidden=FALSE;
        }
    }
}

-(void)_prepareNavigationbar
{
    _anyTouch1 =
    [[UITapGestureRecognizer alloc]
     initWithTarget:self action:@selector(navigationBarTap)];
    [_imgBg_Blur addGestureRecognizer:_anyTouch1];
}

-(void)SetTableViewSize
{
    if (Flag_AdsBanner==1) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            _tblContentList.frame=CGRectMake(_tblContentList.frame.origin.x,_tblContentList.frame.origin.y, _tblContentList.frame.size.width,_tblContentList.frame.size.height-50);
        }
        else{
            _tblContentList.frame=CGRectMake(_tblContentList.frame.origin.x,_tblContentList.frame.origin.y, _tblContentList.frame.size.width,_tblContentList.frame.size.height-90);
        }
    }
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
    // Return the number of rows in the section.
    return [[AppDelegate sharedInstance].arrContent count];
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
        
        if ([[AppDelegate sharedInstance].arrContent count]!=0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            UILabel *lblTitle = [[UILabel alloc] init];
            
            lblTitle.adjustsFontSizeToFitWidth = YES;
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
            
            [cell.contentView addSubview:lblTitle];
            lblTitle.lineBreakMode=NSLineBreakByCharWrapping;
            lblTitle.numberOfLines=0;
            [lblTitle setBackgroundColor:[UIColor clearColor]];
            [lblTitle setTextColor:[UIColor whiteColor]];
            
            UIImageView *imgProduct;
            UIView *viewimage;
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 45,30)];
//                viewimage = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 45,43)];
                imgProduct.layer.cornerRadius=5;
//                viewimage.layer.cornerRadius=15;
//                viewimage.backgroundColor=[UIColor redColor];
//                [cell.contentView addSubview:viewimage];
            }
            else
            {
                imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 60)];
                imgProduct.layer.cornerRadius=10;
            }
            
            [cell.contentView addSubview:imgProduct];
            
            imgProduct.contentMode = UIViewContentModeRedraw;
            imgProduct.clipsToBounds = YES;
            
            [imgProduct setBackgroundColor:[UIColor clearColor]];
            
            if (![[[[AppDelegate sharedInstance].arrContent objectAtIndex:indexPath.row] valueForKey:@"title"] isEqual:[NSNull null]])
            {
                lblTitle.text = [[[AppDelegate sharedInstance].arrContent objectAtIndex:indexPath.row] valueForKey:@"title"];
            }
            else
            {
                lblTitle.text = @"NA";
            }
            
            if (![[[[AppDelegate sharedInstance].arrContent objectAtIndex:indexPath.row] valueForKey:@"image_url"] isEqual:[NSNull null]])
            {
                _str = [[[AppDelegate sharedInstance].arrContent objectAtIndex:indexPath.row] valueForKey:@"image_url"];
                _str = [_str stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            else
                _str = DEFAULT_IMAGE_URL;
            
            [imgProduct setImageWithURL:[NSURL URLWithString:_str] placeholderImage:[UIImage imageNamed:@"pro_img_spotlight.png"]];
            
            lblTitle=nil;
            imgProduct=nil;
            viewimage=nil;
        }
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _headerView = [[UIView alloc] init];
    
    [_headerView setBackgroundColor:[UIColor clearColor]];
    
    [_headerView addSubview:_activity];
    _headerView.hidden=TRUE;
    
    return _headerView;
}

#pragma mark ----  delegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        return 44.0f;
    else
        return 100.0f;
}

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
    [self performSelectorInBackground:@selector(dispatch) withObject:nil];
    
    _imgBg_Blur.hidden=TRUE;
    
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
    
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
    
    [AppDelegate sharedInstance].dictSelected_Product = [[NSMutableDictionary alloc] initWithDictionary:[[AppDelegate sharedInstance].arrContent objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:_scvc animated:YES];
}

- (void)searchTableList
{
    if ([searchBar.text length]<3) {
        searchBar.text=@"";
        _Lenth_SearchBartext=[self.searchBar.text length];
        
        _CurrentPage=0;
        _TotalPage=0;

        [[AppDelegate sharedInstance].arrContent removeAllObjects];

        [self showLoader];
    }
    else
    {
        if ([[AppDelegate sharedInstance].arrContent count]!=0)
        {
            _Lbl_Results.text=[NSString stringWithFormat:@"%d Results",_TotalRecord];
            _Lbl_Results.hidden=FALSE;
        }
    }
    [_tblContentList reloadData];
}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _imgBg_Blur.image=nil;
    _imgBg_Blur.hidden=FALSE;
    
    _Lbl_Results.text=@"";
    _Lbl_Results.hidden=TRUE;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _imgBg_Blur.hidden=TRUE;
    
    self.searchBar.text = @"";
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    _isSearching = NO;
    [self searchTableList];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    _imgBg_Blur.hidden=TRUE;
    
    [self.searchBar setShowsCancelButton:NO animated:YES];
    
    [self.searchBar performSelector: @selector(resignFirstResponder)
                         withObject: nil
                         afterDelay: 0.05];
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(_Flag_CallWebservice==0)
    {
        return  YES;
    }
    return NO;
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _isSearching = YES;
    
    if([searchText length] == 0)
    {
        _isSearching = NO;
        
        _CurrentPage=0;
        _TotalPage=0;
        _imgBg_Blur.hidden=TRUE;
        
        if ([self.searchBar isFirstResponder])
        {
            [self.searchBar resignFirstResponder];
        }
        
        [[AppDelegate sharedInstance].arrContent removeAllObjects];
        
        if ([[AppDelegate sharedInstance].arrContent count]==0)
        {
            _Lbl_Results.text=@"";
            _Lbl_Results.hidden=TRUE;
        }
        
        [self showLoader];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([self.searchBar.text length]<3)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Please, enter keyword to search with minimum 3 character." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [self loadReachability];
        return;
    }
    else
    {
        if ([[AppDelegate sharedInstance].arrContent count]!=0 || [searchBar.text length]==3 || (_Lenth_SearchBartext-1)==[self.searchBar.text length])
        {
            _imgBg_Blur.hidden=TRUE;
            _Lenth_SearchBartext=[self.searchBar.text length];
            _isSearching = YES;
            
            _CurrentPage=0;
            _TotalPage=0;
    
            [self.searchBar resignFirstResponder];
            [[AppDelegate sharedInstance].arrContent removeAllObjects];

            [self showLoader];
            [self searchTableList];
        }
    }
}

#pragma mark - Gesture Method

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"not called");
    return NO;
}

#pragma mark - side view implemenatation

-(void)OpenSideView
{}

#pragma mark - load table

-(void)reLoadTable
{
    [self.tblContentList reloadData];
}

#pragma mark - Loader Methods

-(void) showLoader
{
    if(_Flag_CallWebservice==0)
    {
        _Flag_CallWebservice=1;
        
        //Register fo HUD callbacks
        _HUD.delegate = self;
        
        [MBProgressHUD showHUDAddedTo:[AppDelegate sharedInstance].window animated:YES];
        [self loadProduct];
    }
}

UIAlertView *alert;

-(void)loadProduct
{
    // Check for internet connection
    Reachability* reachability = [Reachability reachabilityWithHostName:@"www.google.co.in"];
    NetworkStatus remote = [reachability currentReachabilityStatus];
    
    if(remote == NotReachable)
    {
        if ([[AppDelegate sharedInstance].arrContent count]==0)
        {
            _Lbl_Results.text=@"";
            _Lbl_Results.hidden=TRUE;
        }
        
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Internet Connection is not available currently. Please check your internet connectivity or try again after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [self loadReachability];
        [_activity stopAnimating];
        
        _headerView.hidden=TRUE;
        [MBProgressHUD hideAllHUDsForView:[AppDelegate sharedInstance].window animated:YES];
        return;
    }
    else
    {
        if (_isSearching==NO)
        {
            _StrApi=[NSString stringWithFormat:@"%@%d",LOAD_PRODUCT_URL,_CurrentPage];
        }
        else
        {
            NSString *str=searchBar.text;
            
            str=[str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            _StrApi=[NSString stringWithFormat:@"%@%@&page=%d",LOAD_SEARCH_PRODUCT_URL,str,_CurrentPage];
        }

        NSURL *url = [NSURL URLWithString:_StrApi];
        
        _request =[[ASIHTTPRequest alloc]initWithURL:url];
        
        _request.delegate=self;
        
        [_request startAsynchronous];
    }
}

#pragma mark - ASIHttprequest Delegates

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self performSelector:@selector(SetFlagValue) withObject:Nil afterDelay:0.1];
    _CurrentPage=0;
    _TotalPage=0;

    alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"Request Fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [self loadReachability];
    
    [[AppDelegate sharedInstance].arrContent removeAllObjects];
    
    if ([[AppDelegate sharedInstance].arrContent count]==0)
    {
        _Lbl_Results.text=@"";
        _Lbl_Results.hidden=TRUE;
    }
    [self ReloadTable];
    
    [_activity stopAnimating];
    _headerView.hidden=TRUE;
    
    [MBProgressHUD hideHUDForView:[AppDelegate sharedInstance].window animated:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    _responseString=[request responseString];
    
    int success=[[[_responseString JSONValue]valueForKey:@"isSuccess"]intValue];
    
    if(success==0)
    {
        [[AppDelegate sharedInstance].arrContent removeAllObjects];
        [self performSelector:@selector(SetFlagValue) withObject:nil afterDelay:0.1];
        
        _CurrentPage=0;
        _TotalPage=0;
        
        alert = [[UIAlertView alloc] initWithTitle:@"Shoe Fax" message:@"No data found. Please try another keyword to search!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [self loadReachability];
        
        if ([[AppDelegate sharedInstance].arrContent count]==0)
        {
            _Lbl_Results.text=@"";
            _Lbl_Results.hidden=TRUE;
        }
    }
    else if(success==1)
    {
        for (NSDictionary *User in [[_responseString JSONValue] objectForKey:@"img-data"])
        {
            [[AppDelegate sharedInstance].arrContent addObject:User];
        }
        
        if ([[AppDelegate sharedInstance].arrContent count]!=0)
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
            
            NSDate *date = [NSDate date];
            
            NSString *formattedDateString = [dateFormatter stringFromDate:date];
            
            [[NSUserDefaults standardUserDefaults] setObject:formattedDateString forKey:@"ShowFAX_SearchDate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            _Lbl_Results.text=[NSString stringWithFormat:@"%d Results",[[[_responseString JSONValue] valueForKey:@"total-records"]  integerValue]];
            _Lbl_Results.hidden=FALSE;
            
            [self performSelector:@selector(SetFlagValue) withObject:Nil afterDelay:0.1];
            
            _TotalRecord=[[[_responseString JSONValue] valueForKey:@"total-records"]  integerValue];
            _CurrentPage=[[[_responseString JSONValue] valueForKey:@"current"]  integerValue];
            _TotalPage=[[[_responseString JSONValue] valueForKey:@"total-pages"] integerValue];
            
            [self ReloadTable];
        }
    }
    
    [_activity stopAnimating];
    _headerView.hidden=TRUE;
    
    [MBProgressHUD hideHUDForView:[AppDelegate sharedInstance].window animated:YES];

}

#pragma mark - PullDownToRefresh Customisation

- (void)refresh
{
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
    
}

- (void)addItem
{
    // Refresh Data
    
    [[AppDelegate sharedInstance].arrContent removeAllObjects ];
    _CurrentPage=0;
    _TotalPage=0;
    
    [self loadProduct];
}

-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [_tblContentList setContentOffset:CGPointZero animated:YES];
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat contentYoffset = scrollView.contentOffset.y;
    
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    
    if(distanceFromBottom < height)
    {
        if (_Flag_CallWebservice==0)
        {
            
            NSLog(@"end of the table");
            
            if (_CurrentPage!=(_TotalPage -1))
            {
                _Flag_CallWebservice=1;
                _CurrentPage++;
                _headerView.hidden=FALSE;
                
                [_activity startAnimating];
                [self loadProduct];
            }
        }
    }
    else
    {
        if (isLoading)
        {
            // Update the content inset, good for section headers
            if (scrollView.contentOffset.y > 0)
                _tblContentList.contentInset = UIEdgeInsetsZero;
            else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
                _tblContentList.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
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
}

- (void)startLoading
{
    if (_Flag_CallWebservice==0) {
        _Flag_CallWebservice=1;
        isLoading = YES;
        
        // Show the header
        [UIView animateWithDuration:0.3 animations:^{
            _tblContentList.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
            refreshLabel.text = self.textLoading;
            refreshArrow.hidden = YES;
            
            NSString *Str=[NSString stringWithFormat:@"%@\nLast Updated: %@",refreshLabel.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"ShowFAX_SearchDate"]];
            
            refreshLabel.text=[NSString stringWithFormat:@"%@",Str];
            [refreshSpinner startAnimating];
        }];
        
        // Refresh action!
        [self refresh];
    }
}

- (void)stopLoading
{
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        _tblContentList.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished)
    {
                         [self stopLoadingComplete];
                     }];
}

#pragma mark - alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{}

#pragma mark - Dealloc

-(void)dealloc
{
    if (Flag_SelectedView!=0)
    {
        if (_request!=nil) {
            [_request cancel];
            _request.delegate=nil;
            _request=nil;
        }
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        [_activity stopAnimating];
        _headerView.hidden=TRUE;
        
        if ([AppDelegate sharedInstance].arrContent!=nil) {
            [[AppDelegate sharedInstance].arrContent removeAllObjects];
            [AppDelegate sharedInstance].arrContent=nil;
        }
        [MBProgressHUD hideHUDForView:[AppDelegate sharedInstance].window animated:YES];
        
        
    }
    
    _Lbl_Results=nil;
    
    _activity=nil;
    _tblContentList=nil;
    self.searchBar=nil;
    self.searchBarController=nil;
    _HUD=nil;
    _scvc=nil;
    
    _imgBg=nil;
    _imgBg_Blur=nil;
    
    _anyTouch=nil;
    _anyTouch1=nil;
    
    _headerView=nil;
    _str=nil;
    _StrApi=nil;
    _responseString=nil;
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
