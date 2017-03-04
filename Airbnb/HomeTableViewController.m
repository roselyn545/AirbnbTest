//
//  HomeTableViewController.m
//  Airbnb
//
//  Created by Roselyn on 1/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "HomeTableViewController.h"
#import "LodgingTableViewCell.h"
#import "WebService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LodgingDetailViewController.h"
#import "SVProgressHUD.h"

@interface HomeTableViewController ()<WebServiceProtocol,LocationManagerProtocol>

@property (nonatomic) UILabel *emptyLabel;
@property (nonatomic) WebService* WS;
@property (nonatomic) RemoteLodging *selected;
@end

@implementation HomeTableViewController

@synthesize WS;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS=[WebService sharedInstance];
    WS.myDelegate = self;
    [LocationManager sharedInstance].myDelegate=self;
    self.navigationItem.title = [LocationManager sharedInstance].city;
    //[WS loadLodgingsFromServer];
    
    self.emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.emptyLabel.center= CGPointMake(self.view.center.x, self.view.center.y-self.navigationController.navigationBar.frame.size.height);
    self.emptyLabel.text= @"Empty list";
    self.emptyLabel.hidden=YES;
    self.emptyLabel.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel.textColor =[UIColor lightGrayColor];
    self.emptyLabel.font = [UIFont systemFontOfSize:18];
    self.emptyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.emptyLabel.numberOfLines=0;
    [self.view addSubview:self.emptyLabel];
    //[self.view bringSubviewToFront:self.emptyLabel];

    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:60/255.0 green:213/255.0 blue: 201/255.0 alpha:1]];

    if (WS.lodgingsList==nil)
        [SVProgressHUD show];
}

-(void) updateLocation:(NSString*)city {
    self.navigationItem.title =city;
}

-(void) listUpdated{
    NSLog(@"debo actualizar la tabla");
    self.navigationItem.title = [LocationManager sharedInstance].city;
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
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
    if ([WS.lodgingsList count]==0){
        self.emptyLabel.hidden=NO;
        self.emptyLabel.text=@"No lodgings were found\nfor this city";
    }else{
        self.emptyLabel.hidden=YES;
    }
    return [WS.lodgingsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LodgingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lodging_cell" forIndexPath:indexPath];
    
    RemoteLodging *rl = [WS.lodgingsList objectAtIndex:indexPath.row];
    
    cell.title.text = rl.name;
    cell.location.text = rl.type;
    cell.price.text = rl.price;
    if (rl.isFavorite){
        cell.favoriteImage.image = [UIImage imageNamed:@"favorite_active"];
    }else{
        cell.favoriteImage.image = [UIImage imageNamed:@"favorite_inactive"];
    }
    cell.isFavorite=rl.isFavorite;
    
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:rl.userImageUrl]
                      placeholderImage:[UIImage imageNamed:@"placeholder_user3"]
                               options:SDWebImageRefreshCached];
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:rl.imageUrl]
                   placeholderImage:[UIImage imageNamed:@"placeholder_item"]
                            options:SDWebImageRefreshCached];
    
    cell.favoriteImage.userInteractionEnabled=YES;
        
    UITapGestureRecognizer *changeFavorite = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self
                                                 action:@selector(changeFavorite:)];
    changeFavorite.numberOfTapsRequired = 1;
    [cell.favoriteImage addGestureRecognizer:changeFavorite];
    
    return cell;
}

-(void) changeFavorite:(UITapGestureRecognizer*) gesture{
    LodgingTableViewCell *cell =(LodgingTableViewCell*)gesture.view.superview.superview;
    NSIndexPath* ip=[self.tableView indexPathForCell:cell];
    RemoteLodging *rl = [WS.lodgingsList objectAtIndex:ip.row];

    if (cell.isFavorite){
        cell.favoriteImage.image = [UIImage imageNamed:@"favorite_inactive"];
        [FavoriteLodging removeFromFavoritesLodgingId:[rl.id_ integerValue]];
        rl.isFavorite=cell.isFavorite=!cell.isFavorite;
    }else{
        if (rl.description){
            [FavoriteLodging addToFavoritesLodgingWithData:rl];
            cell.favoriteImage.image = [UIImage imageNamed:@"favorite_active"];
            rl.isFavorite=cell.isFavorite=!cell.isFavorite;
        }else{
            [SVProgressHUD show];
            self.selected=rl;
            [WS getDetailLodgingFromServer:[rl.id_ integerValue]];
            [FavoriteLodging addToFavoritesLodgingWithData:rl];
            cell.favoriteImage.image = [UIImage imageNamed:@"favorite_active"];
            rl.isFavorite=cell.isFavorite=!cell.isFavorite;
        }
    }
}

- (void)loadDesctiption:(NSString*)description{
    self.selected.completeDescription=description;
    [FavoriteLodging updateFavoriteLodging:[self.selected.id_ integerValue] withDescription:description];
    [SVProgressHUD dismiss];
}

-(void) errorInRequest:(int)request error:(NSError *)error{
    [SVProgressHUD dismiss];
    
    if (request==1){
        self.emptyLabel.hidden=NO;
        if (error.code==-1009)
            self.emptyLabel.text=@"You don't have\ninternet connection";
        else
            self.emptyLabel.text=@"An error\nhas ocurred!";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LodgingDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"lodging_detail"];
    vc.lodging = [WS.lodgingsList objectAtIndex:indexPath.row];
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}



@end
