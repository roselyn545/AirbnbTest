//
//  Lodging.h
//  Nextdots
//
//  Created by Roselyn on 3/2/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_Lodging.h"
#import "RemoteLodging.h"


@interface FavoriteLodging : _Lodging

+ (NSArray *) getAllFavoritesLodgings;
+ (void) addToFavoritesLodgingWithData: (RemoteLodging *)remote;
+(bool) removeFromFavoritesLodgingId: (int64_t) idLodging;
+ (NSManagedObjectContext *) managedObjectContext;
+(FavoriteLodging *) getLodgingFromId: (int64_t) idLodging;
+(void) updateFavoriteLodging:(int64_t) id_ withDescription: (NSString *)description;

@end
