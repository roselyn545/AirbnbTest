//
//  _Lodging+CoreDataProperties.m
//  Airbnb
//
//  Created by Roselyn on 4/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "_Lodging+CoreDataProperties.h"

@implementation _Lodging (CoreDataProperties)

+ (NSFetchRequest<_Lodging *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Lodging"];
}

@dynamic completeDescription;
@dynamic id_;
@dynamic imageUrl;
@dynamic isFavorite;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic numberOfBathrooms;
@dynamic numberOfBedrooms;
@dynamic numberOfBeds;
@dynamic numberOfGuests;
@dynamic price;
@dynamic publicAddress;
@dynamic roomType;
@dynamic type;
@dynamic userImageUrl;
@dynamic userName;
@dynamic favoriteOwner;

@end
