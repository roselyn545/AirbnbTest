//
//  LoginViewController.m
//  Airbnb
//
//  Created by Roselyn on 4/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Login");

    self.fbLoginButton.readPermissions = @[@"public_profile"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeTokenChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeProfileChange:) name:FBSDKProfileDidChangeNotification object:nil];
}

- (void)observeTokenChange:(NSNotification *)notfication {
    NSLog(@"observeTokenChange notification %@",notfication);
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self observeProfileChange:nil];
    }
}

- (void)observeProfileChange:(NSNotification *)notfication {
    NSLog(@"observeProfileChange notification %@",notfication);
    
    if ([FBSDKProfile currentProfile]) {
        //crear preferences
        NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
        [preferences  setObject:[FBSDKProfile currentProfile].name forKey:@"name"];
        [preferences  setObject:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [FBSDKProfile currentProfile].userID] forKey:@"imageUrl"];
        [preferences  setObject:[FBSDKProfile currentProfile].userID forKey:@"id_"];
        
        const BOOL didSave = [preferences synchronize];
        if(!didSave)
        {
            NSLog(@"logged");
        }
        
         [self performSegueWithIdentifier:@"show_tab_bar" sender:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
