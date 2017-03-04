//
//  LodgingTableViewCell.m
//  Airbnb
//
//  Created by Roselyn on 1/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "LodgingTableViewCell.h"

@implementation LodgingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userImage.layer.masksToBounds=YES;
    self.userImage.layer.cornerRadius=25;
    self.userImage.layer.borderColor=[UIColor whiteColor].CGColor;
    self.userImage.layer.borderWidth=1;
    self.price.layer.masksToBounds=YES;
    self.price.layer.cornerRadius=5;
    
    if (self.favoriteImage){
        self.favoriteImage.layer.borderColor=[UIColor whiteColor].CGColor;
        self.favoriteImage.layer.borderWidth=1;
        self.favoriteImage.layer.masksToBounds=YES;
        self.favoriteImage.layer.cornerRadius=20;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
