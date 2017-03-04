//
//  FirstViewController.h
//  Airbnb
//
//  Created by Roselyn on 1/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *location;
- (IBAction)openFavorites:(id)sender;
- (IBAction)logout:(id)sender;

@end

