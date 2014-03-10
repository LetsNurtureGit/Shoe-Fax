//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "MostExpensiveVC.h"
#import "ViewController.h"
#import "Trending.h"
#import "RecentlyView.h"

@implementation SideMenuViewController

-(void)viewDidLoad
{
   // self.tableView.backgroundColor=[UIColor blackColor];
    
//    self.tableView1=[[UITableView alloc] init];
//    self.tableView1.delegate=self;
//    self.tableView1.dataSource=self;
//    self.tableView1.backgroundColor=[UIColor colorWithRed:81.0/255.0 green:66.0/255.0 blue:67.0/255.0 alpha:1.0];
//    self.view.backgroundColor=[UIColor colorWithRed:81.0/255.0 green:66.0/255.0 blue:67.0/255.0 alpha:1.0];
//    self.tableView1.frame=CGRectMake(0, self.tableView1.frame.origin.y, self.tableView1.frame.size.width, self.view.frame.size.height+20);
//    self.tableView1.bounces=NO;
//
//    [self.view addSubview:self.tableView1];
//
    
    self.tableView.backgroundColor=[UIColor colorWithRed:81.0/255.0 green:66.0/255.0 blue:67.0/255.0 alpha:1.0];
    self.view.backgroundColor=[UIColor colorWithRed:81.0/255.0 green:66.0/255.0 blue:67.0/255.0 alpha:1.0];
    self.tableView.frame=CGRectMake(0, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.view.frame.size.height+20);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.bounces=NO;
    
    

    


    

}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    if (section == 0)
    return @"Shoe Fax";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0)) {

    return 44;
    }
    return 64;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return 44;
    else
        return 61;
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    for (NSString* family in [UIFont familyNames])
    //    {
    //        NSLog(@"%@", family);
    //
    //        for (NSString* name in [UIFont fontNamesForFamilyName: family])
    //        {
    //            NSLog(@"  %@", name);
    //        }
    //    }
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(55, 25, 320, 30);
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];

    label.font=[UIFont fontWithName:@"Homestead-Display" size:20];
    label.text = @"Shoe Fax";
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(15, 27, 32, 32)];
    
    if([appDelegate isIpad])
    {
        if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0))
        {
            imgLogo.frame=CGRectMake(60, 3, 32, 32);
            label.frame = CGRectMake(104, 5, 320, 30);
        }
        else
        {
            imgLogo.frame=CGRectMake(60, 25, 32, 32);
            label.frame = CGRectMake(104, 28, 320, 30);
        }
    }
    else if([appDelegate isIphone]||[appDelegate isIphone5])
    {
        if (([[[UIDevice currentDevice] systemVersion] floatValue] <7.0))
        {
            imgLogo.frame=CGRectMake(67, 3, 32, 32);
            label.frame = CGRectMake(110, 5, 320, 30);
        }
        else
        {
            imgLogo.frame=CGRectMake(67, 25, 32, 32);
            label.frame = CGRectMake(110, 28, 320, 30);
        }
    }
    
    [imgLogo setImage:[UIImage imageNamed:@"Shoe_logo_Iphone"]];
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    [view addSubview:imgLogo];
    view.backgroundColor=[UIColor blackColor];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(40, 8, 320, 30);
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    
    if (indexPath.row==0)
    {
        label.text =@"Search";
    }
    else if (indexPath.row==1)
    {
        label.text =@"Most Expensive";
    }
    else if (indexPath.row==2)
    {
        label.text =@"Trending";
    }
    else if (indexPath.row==3)
    {
        label.text =@"Recently Added";
    }
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(4, 8, 28, 28)];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)
    {
        label.frame = CGRectMake(60, 10, 537, 42);
        [label setFont:[UIFont boldSystemFontOfSize:20.0]];
        
        imgLogo.frame=CGRectMake(10, 11, 40, 40);
    }
    UILabel *label_Line = [[UILabel alloc] init];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        label_Line.frame = CGRectMake(0, cell.frame.size.height-1, self.view.frame.size.width, 1);
        
        switch (indexPath.row)
        {
            case 0:
                imgLogo.image = [UIImage imageNamed:@"search_iphone.png"];
                break;
            case 1:
                imgLogo.image = [UIImage imageNamed:@"expensive_iphone.png"];
                break;
                
            case 2:
                imgLogo.image = [UIImage imageNamed:@"trending_iphone.png"];
                break;
                
            case 3:
                imgLogo.image = [UIImage imageNamed:@"recent_added_iPhone.png"];
                break;
        }
    }
    else
    {
        label_Line.frame = CGRectMake(0, 59, self.view.frame.size.width, 2);
        
        switch (indexPath.row)
        {
                
            case 0:
                imgLogo.image = [UIImage imageNamed:@"search_ipad.png"];
                break;
            case 1:
                imgLogo.image = [UIImage imageNamed:@"expensive_ipad.png"];
                break;
                
            case 2:
                imgLogo.image = [UIImage imageNamed:@"trending_ipad.png"];
                break;
                
            case 3:
                imgLogo.image = [UIImage imageNamed:@"recent_added_ipad.png"];
                break;
        }
    }
    
    label_Line.backgroundColor=[UIColor lightGrayColor];
    label_Line.alpha=0.1;
    [cell.contentView addSubview:label_Line];
    
    [cell.contentView addSubview:imgLogo];
    [cell.contentView addSubview:label];
    
    if (indexPath.row==Flag_SelectedView) {
        
        cell.backgroundColor=[UIColor colorWithRed:50.0/255.0 green:39.0/255.0 blue:41.0/255.0 alpha:1.0];
        
    }
    else{
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    label=nil;
    label_Line=nil;
    imgLogo=nil;
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        [self dispatch];
    }
    else if (indexPath.row==1) {
        [self dispatch_MostExpensive];
    }
    else if (indexPath.row==2) {
        [self dispatch_Trending];
    }
    else if (indexPath.row==3) {
        [self dispatch_Recently];
    }
//    else if (indexPath.row==4)
//    {
//        [self dispatch_settings];
//    }
    
    if (Flag_SelectedView!=indexPath.row)
    {
        NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:Flag_SelectedView inSection:0];
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath1];
        selectedCell.backgroundColor = [UIColor clearColor];
        
        selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        selectedCell.backgroundColor=[UIColor colorWithRed:50.0/255.0 green:39.0/255.0 blue:41.0/255.0 alpha:1.0];
        
        
        
        NSArray *controllers;
        if (indexPath.row==0) {
            ViewController *demoController;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
                demoController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            else
                demoController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
            //demoController.title = [NSString stringWithFormat:@"ViewController #%d-%d", indexPath.section, indexPath.row];
            controllers = [NSArray arrayWithObject:demoController];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            navigationController.navigationBar.backgroundColor=[UIColor blackColor];
            navigationController.viewControllers = controllers;
            
            
            
        }
        else if (indexPath.row==1) {
            
            MostExpensiveVC *demoController;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
                demoController = [[MostExpensiveVC alloc] initWithNibName:@"MostExpensiveVC" bundle:nil];
            else
                demoController = [[MostExpensiveVC alloc] initWithNibName:@"MostExpensiveVC_iPad" bundle:nil];
            //  demoController.title = [NSString stringWithFormat:@"ViewController #%d-%d", indexPath.section, indexPath.row];
            controllers = [NSArray arrayWithObject:demoController];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            navigationController.navigationBar.backgroundColor=[UIColor blackColor];
            navigationController.viewControllers = controllers;
            
        }
        else if (indexPath.row==2) {
            
            Trending *demoController;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
                demoController = [[Trending alloc] initWithNibName:@"Trending" bundle:nil];
            else
                demoController = [[Trending alloc] initWithNibName:@"Trending_iPad" bundle:nil];
            // demoController.title = [NSString stringWithFormat:@"ViewController #%d-%d", indexPath.section, indexPath.row];
            controllers = [NSArray arrayWithObject:demoController];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            navigationController.navigationBar.backgroundColor=[UIColor blackColor];
            navigationController.viewControllers = controllers;
            
        }
        else if (indexPath.row==3) {
            
            RecentlyView *demoController;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
                demoController = [[RecentlyView alloc] initWithNibName:@"RecentlyView" bundle:nil];
            else
                demoController = [[RecentlyView alloc] initWithNibName:@"RecentlyView_iPad" bundle:nil];
            // demoController.title = [NSString stringWithFormat:@"ViewController #%d-%d", indexPath.section, indexPath.row];
            controllers = [NSArray arrayWithObject:demoController];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            navigationController.navigationBar.backgroundColor=[UIColor blackColor];
            navigationController.viewControllers = controllers;
            
        }
//        else if (indexPath.row==4)
//        {
//            SettingsController *settings;
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//                settings = [[SettingsController alloc] initWithNibName:@"SettingsController" bundle:nil];
//            else
//                settings = [[SettingsController alloc] initWithNibName:@"RecentlyView_iPad" bundle:nil];
//            // demoController.title = [NSString stringWithFormat:@"ViewController #%d-%d", indexPath.section, indexPath.row];
//            controllers = [NSArray arrayWithObject:settings];
//            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//            navigationController.navigationBar.backgroundColor=[UIColor blackColor];
//            navigationController.viewControllers = controllers;
//        }
        Flag_SelectedView=indexPath.row;

    }
    
    
   
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}


#pragma mark -
#pragma mark - Google analytic Events

- (void)dispatch {
    
    // self.screenName=@"Search Product";
    
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Search"
                                            action:@"Button Press Search"
                                             label:@"Search"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
}
- (void)dispatch_MostExpensive
{
    //  self.screenName=@"Most Expensive";
    
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Most Expensive"
                                            action:@"Button Press Most Expensive"
                                             label:@"Most Expensive"
                                             value:nil] build];
    
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
}
- (void)dispatch_Trending {
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Trending"
                                            action:@"Button Press Trending"
                                             label:@"Trending"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
}
- (void)dispatch_Recently
{
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Recently Added"
                                            action:@"Button Press Recently Added"
                                             label:@"Recently Added"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
}

- (void)dispatch_settings
{
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Settings"
                                            action:@"Button Press Settings"
                                             label:@"Settings"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
}

@end
