//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "ViewController.h"

@implementation SideMenuViewController
- (MFSideMenuContainerViewController *)menuContainerViewController
{
    return (MFSideMenuContainerViewController *)self.parentViewController;
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    if (section == 0)
        return @"Shoe Fax";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0)
//        return 2;
//    else
//        return 4;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    switch (indexPath.section)
    {
        case 0:
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"Upcoming";
                    break;
                case 1:
                    cell.textLabel.text = @"Past";
                    break;
         
                default:
                    break;
            }
            break;
//        case 1:
//            switch (indexPath.row)
//            {
//                case 0:
//                    cell.imageView.image = [UIImage imageNamed:@"text_icn.png"];
//                    cell.textLabel.text = @"Text";
//                    break;
//
//                case 1:
//                    cell.imageView.image = [UIImage imageNamed:@"photo_icn.png"];
//                    cell.textLabel.text = @"Photo";
//                    break;
//                
//                case 2:
//                    cell.imageView.image = [UIImage imageNamed:@"audio_icn.png"];
//                    cell.textLabel.text = @"Audio";
//                    break;
//
//                case 3:
//                    cell.imageView.image = [UIImage imageNamed:@"video_icn.png"];
//                    cell.textLabel.text = @"Video";
//                    break;
//                default:
//                    break;
//            }
//            break;
//                    
        default:
            break;
    }
    // assign cell text
    cell.textLabel.textColor = [UIColor blackColor];
//    cell.textLabel.font = [UIFont fontWithName:@"PTS55F.ttf" size:12];
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *vc;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        vc = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    else
        vc = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
    
    // assign sectionwise viewcontrollers
    
    NSArray *secArray = nil;
    
//    switch (indexPath.section)
//    {
//        case 0:
//            secArray = [[[NSArray alloc] initWithObjects:uvc,pvc,nil] autorelease];
//            break;
//
//        case 1:
//            secArray = [[[NSArray alloc] initWithObjects:trvc,prvc,arvc,vrvc,nil] autorelease];
//            break;
//
//        default:
//            break;
//    }

 //   switch (indexPath.section)
 //   {
 //       case 0:
            secArray = [[[NSArray alloc] initWithObjects:vc,nil] autorelease];
//            break;
//            
//        case 1:
//            secArray = [[[NSArray alloc] initWithObjects:trvc,prvc,arvc,vrvc,nil] autorelease];
//            break;
//            
//        default:
//            break;
//    }

    
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
  //  [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];
    NSArray *controllers = [NSArray arrayWithObject:[secArray objectAtIndex:indexPath.row]];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

@end
