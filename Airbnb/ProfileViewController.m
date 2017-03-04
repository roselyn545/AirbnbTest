//
//  FirstViewController.m
//  Airbnb
//
//  Created by Roselyn on 1/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "ProfileViewController.h"
#import "LocationManager.h"
#import "FavoritesTableViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.profileImage.layer.masksToBounds=YES;
    self.profileImage.layer.cornerRadius=50;
    self.profileImage.layer.borderColor=[UIColor colorWithRed:254/255.0 green:90/255.0 blue: 95/255.0 alpha:1].CGColor;
    self.profileImage.layer.borderWidth=1;
    self.location.text = [LocationManager sharedInstance].city;
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    self.name.text = [preferences objectForKey:@"name"];
    
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:[preferences objectForKey:@"imageUrl"]]
                      placeholderImage:[UIImage imageNamed:@""]
                               options:SDWebImageRefreshCached];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openFavorites:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoritesTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"favorites"];
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)logout:(id)sender {
    [[FBSDKLoginManager new]logOut];
    
    NSUserDefaults * preferences = [NSUserDefaults standardUserDefaults];
    [preferences removeObjectForKey:@"name"];
    [preferences removeObjectForKey:@"imageUrl"];
    [preferences removeObjectForKey:@"_id"];
    [preferences synchronize];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *navController =(UINavigationController *)appDelegate.window.rootViewController;
    if (navController.viewControllers.count==1){
        NSLog (@"only tabbar");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        navController.viewControllers = @[self.tabBarController,[storyboard instantiateViewControllerWithIdentifier:@"login"]];

    }else{
        NSLog (@"with login");
        [navController popToRootViewControllerAnimated:YES];
    }
}

@end
