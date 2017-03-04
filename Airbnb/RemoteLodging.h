//
//  RemoteLodging.h
//  Airbnb
//
//  Created by Roselyn on 2/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteLodging : NSObject

@property (nonatomic) NSString *imageUrl;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *type;
@property (nonatomic) NSNumber *id_;
@property (nonatomic) NSString *userImageUrl;
@property (nonatomic) NSString *completeDescription;
@property (nonatomic) NSNumber *latitude;
@property (nonatomic) NSNumber *longitude;
@property (nonatomic) NSNumber *numberOfBathrooms;
@property (nonatomic) NSNumber *numberOfBedrooms;
@property (nonatomic) NSNumber *numberOfBeds;
@property (nonatomic) NSNumber *numberOfGuests;
@property (nonatomic) NSString *publicAddress;
@property (nonatomic) NSString *roomType;
@property (nonatomic) NSString *userName;
@property (nonatomic) BOOL isFavorite;

+(RemoteLodging *) initFromDictionary: (NSDictionary *)dict favorite:(bool) isFavorite;

- (NSString *) stringValue;

@end
