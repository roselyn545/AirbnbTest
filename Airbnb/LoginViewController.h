//
//  LoginViewController.h
//  Airbnb
//
//  Created by Roselyn on 4/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginButton;

@end
