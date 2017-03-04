//
//  _Lodging+CoreDataProperties.h
//  Airbnb
//
//  Created by Roselyn on 4/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "_Lodging.h"


NS_ASSUME_NONNULL_BEGIN

@interface _Lodging (CoreDataProperties)

+ (NSFetchRequest<_Lodging *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *completeDescription;
@property (nullable, nonatomic, copy) NSNumber *id_;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSNumber *isFavorite;
@property (nullable, nonatomic, copy) NSNumber *latitude;
@property (nullable, nonatomic, copy) NSNumber *longitude;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *numberOfBathrooms;
@property (nullable, nonatomic, copy) NSNumber *numberOfBedrooms;
@property (nullable, nonatomic, copy) NSNumber *numberOfBeds;
@property (nullable, nonatomic, copy) NSNumber *numberOfGuests;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *publicAddress;
@property (nullable, nonatomic, copy) NSString *roomType;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *userImageUrl;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *favoriteOwner;

@end

NS_ASSUME_NONNULL_END
