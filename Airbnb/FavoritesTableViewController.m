//
//  FavoritesTableViewController.m
//  Airbnb
//
//  Created by Roselyn on 3/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "FavoriteLodging.h"
#import "LodgingTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LodgingDetailViewController.h"
#import "HomeTableViewController.h"
#import "WebService.h"

@interface FavoritesTableViewController ()
@property (nonatomic) UILabel *emptyLabel;
@end

@implementation FavoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.favorites = [[FavoriteLodging getAllFavoritesLodgings] mutableCopy];
    
    self.emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.emptyLabel.center= CGPointMake(self.view.center.x, self.view.center.y-self.navigationController.navigationBar.frame.size.height);
    self.emptyLabel.text= @"You not have\nany favorite";
    self.emptyLabel.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel.textColor =[UIColor lightGrayColor];
    self.emptyLabel.font = [UIFont systemFontOfSize:18];
    self.emptyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.emptyLabel.numberOfLines=0;
    self.emptyLabel.hidden=YES;
    [self.view addSubview:self.emptyLabel];
    [self.view bringSubviewToFront:self.emptyLabel];
    
    if (self.favorites.count==0){
        self.emptyLabel.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LodgingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lodging_cell" forIndexPath:indexPath];
    
    FavoriteLodging *fav = [self.favorites objectAtIndex:indexPath.row];
    //NSLog(@"fav %@",fav.isFavorite);
    
    cell.title.text = fav.name;
    cell.location.text = fav.type;
    cell.price.text = fav.price;
    cell.isFavorite=YES;
    
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:fav.userImageUrl]
                      placeholderImage:[UIImage imageNamed:@"placeholder_user3"]
                               options:SDWebImageRefreshCached];
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:fav.imageUrl]
                      placeholderImage:[UIImage imageNamed:@"placeholder_item"]
                               options:SDWebImageRefreshCached];
    
    cell.favoriteImage.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *changeFavorite = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(deleteFavorite:)];
    changeFavorite.numberOfTapsRequired = 1;
    [cell.favoriteImage addGestureRecognizer:changeFavorite];
    
    return cell;
}
-(void) deleteFavorite:(UITapGestureRecognizer*) gesture{
    LodgingTableViewCell *cell =(LodgingTableViewCell*)gesture.view.superview.superview;
    NSIndexPath* ip=[self.tableView indexPathForCell:cell];
    RemoteLodging *rl = [self.favorites objectAtIndex:ip.row];

    [FavoriteLodging removeFromFavoritesLodgingId:[rl.id_ integerValue]];
    [self.favorites removeObjectAtIndex:ip.row];
    [self.tableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];

    NSLog(@"%@",((HomeTableViewController *)(((UITabBarController *)[(self.navigationController.viewControllers) objectAtIndex:0]).viewControllers[1])));
    
    for (RemoteLodging *dict in [WebService sharedInstance].lodgingsList){
        if ([dict.id_ integerValue]==[rl.id_ integerValue]){
            dict.isFavorite=NO;
        }
    }
    
    [((HomeTableViewController *)(((UINavigationController*)(((UITabBarController *)[(self.navigationController.viewControllers) objectAtIndex:0]).viewControllers)[1]).topViewController)).tableView reloadData];
    
    if (self.favorites.count==0){
        self.emptyLabel.hidden=NO;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LodgingDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"lodging_detail"];
    vc.lodging = [self.favorites objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent=NO;
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent=YES;
    [self.navigationController setNavigationBarHidden:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
