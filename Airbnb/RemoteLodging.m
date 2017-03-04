//
//  RemoteLodging.m
//  Airbnb
//
//  Created by Roselyn on 2/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "RemoteLodging.h"

@implementation RemoteLodging

+(RemoteLodging *) initFromDictionary: (NSDictionary *)dict favorite:(bool) isFavorite{
    RemoteLodging *lodging = [[RemoteLodging alloc] init];
    
    NSDictionary *listing = [dict objectForKey:@"listing"];

    lodging.id_ = [NSNumber numberWithInteger:[[listing objectForKey:@"id"] integerValue]];
    lodging.name = [listing objectForKey:@"name"];
    lodging.imageUrl = [listing objectForKey:@"picture_url"];
    lodging.type = [listing objectForKey:@"property_type"];
    //lodging.completeDescription = [dict objectForKey:@""];
    lodging.latitude = [listing objectForKey:@"lat"] && ![[listing objectForKey:@"lat"]isKindOfClass:[NSNull class]]?[NSNumber numberWithFloat:[[listing objectForKey:@"lat"] floatValue]]:0;
    lodging.longitude = [listing objectForKey:@"lng"] && ![[listing objectForKey:@"lng"]isKindOfClass:[NSNull class]]?[NSNumber numberWithFloat:[[listing objectForKey:@"lng"] floatValue]]:0;
    lodging.numberOfBathrooms = [listing objectForKey:@"bathrooms"] && ![[listing objectForKey:@"bathrooms"]isKindOfClass:[NSNull class]]?[NSNumber numberWithInteger:[[listing objectForKey:@"bathrooms"] integerValue]]:0;
    lodging.numberOfBedrooms = [listing objectForKey:@"bedrooms"] && ![[listing objectForKey:@"bedrooms"]isKindOfClass:[NSNull class]] ?[NSNumber numberWithInteger:[[listing objectForKey:@"bedrooms"] integerValue]]:0;
    lodging.numberOfBeds = [listing objectForKey:@"beds"] && ![[listing objectForKey:@"beds"]isKindOfClass:[NSNull class]]?[NSNumber numberWithInteger:[[listing objectForKey:@"beds"] integerValue]]:0;
    lodging.numberOfGuests = [listing objectForKey:@"person_capacity"] && ![[listing objectForKey:@"person_capacity"]isKindOfClass:[NSNull class]]?[NSNumber numberWithInteger:[[listing objectForKey:@"person_capacity"] integerValue]]:0;
    lodging.publicAddress = [listing objectForKey:@"public_address"];
    lodging.roomType = [listing objectForKey:@"room_type"];
    lodging.isFavorite = isFavorite;
    
    NSDictionary *user = [listing objectForKey:@"user"];
    lodging.userImageUrl = [user objectForKey:@"picture_url"];
    lodging.userName = [user objectForKey:@"first_name"];
    
    lodging.price = lodging.price = [NSString stringWithFormat:@"%.0f %@ ",[[[dict objectForKey:@"pricing_quote"] objectForKey:@"localized_nightly_price"] floatValue],[[dict objectForKey:@"pricing_quote"] objectForKey:@"localized_currency"]];
    
    return lodging;
}

-(NSString *) stringValue{
    return [NSString stringWithFormat:@"Lodging @{ id : %li, name : %@, imageUrl : %@, type : %@, publicAddress : %@, userName : %@ }",(long)[self.id_ integerValue], self.name, self.imageUrl, self.type, self.publicAddress, self.userName];
}

@end
