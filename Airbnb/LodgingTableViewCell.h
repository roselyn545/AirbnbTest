//
//  LodgingTableViewCell.h
//  Airbnb
//
//  Created by Roselyn on 1/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteLodging.h"
@interface LodgingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (nonatomic) BOOL isFavorite;

@end
