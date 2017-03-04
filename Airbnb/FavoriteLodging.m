//
//  Lodging.m
//  Nextdots
//
//  Created by Roselyn on 3/2/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "FavoriteLodging.h"
#import "AppDelegate.h"

@implementation FavoriteLodging

+(NSArray *) getAllFavoritesLodgings{

    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSLog(@"id user %@",[preferences objectForKey:@"id_"]);

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Lodging"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"isFavorite == %@ AND favoriteOwner==%@",[NSNumber numberWithInt:1],[preferences objectForKey:@"id_"]];
    [request setPredicate:predicate];
    NSError *error;
    
    NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if (array == nil){
        NSLog(@"ha ocurrido un error en detLodging");
    }
    return array;
}

+(FavoriteLodging *) getLodgingFromId: (int64_t) idLodging{
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Lodging"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"id_ == %i AND favoriteOwner==%@",idLodging,[preferences objectForKey:@"id_"]];//AND isFavorite == true
    
    
    [request setPredicate:predicate];
    NSError *error;
    
    NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if (array == nil){
        NSLog(@"ha ocurrido un error en detLodging");
    }
    if ([array count]>0)
        return [array firstObject];
    return nil;
}

+(bool) removeFromFavoritesLodgingId: (int64_t) idLodging{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    FavoriteLodging *favorite =[self getLodgingFromId:idLodging];
    if (favorite){
        favorite.isFavorite = false;
    }else{
        return false;
    }
    
    [appDelegate saveContext];
    return true;
}

+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

+(void) addToFavoritesLodgingWithData: (RemoteLodging *)remote{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    

    FavoriteLodging *favorite =[self getLodgingFromId:[remote.id_ integerValue]];
    if (favorite==nil){
        favorite = [NSEntityDescription insertNewObjectForEntityForName:@"Lodging" inManagedObjectContext:[self managedObjectContext]];
        
        favorite.imageUrl=remote.imageUrl;
        favorite.name=remote.name;
        favorite.price=remote.price;
        favorite.type=remote.type;
        favorite.id_=remote.id_;
        favorite.userImageUrl=remote.userImageUrl;
        favorite.completeDescription=remote.completeDescription;
        favorite.latitude=remote.latitude;
        favorite.longitude=remote.longitude;
        favorite.numberOfBathrooms=remote.numberOfBathrooms;
        favorite.numberOfBedrooms=remote.numberOfBedrooms;
        favorite.numberOfBeds=remote.numberOfBeds;
        favorite.numberOfGuests=remote.numberOfGuests;
        favorite.publicAddress=remote.publicAddress;
        favorite.roomType=remote.roomType;
        favorite.userName=remote.userName;
        favorite.isFavorite = [NSNumber numberWithInt:1];
        NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
        favorite.favoriteOwner = [preferences objectForKey:@"id_"];
        
    }else{
        favorite.isFavorite=[NSNumber numberWithInt:1];
    }
        
    [appDelegate saveContext];
}

+(void) updateFavoriteLodging:(int64_t) id_ withDescription: (NSString *)description{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    FavoriteLodging *favorite =[self getLodgingFromId:id_];
    if (favorite){
        favorite.completeDescription=description;
    }
    
    [appDelegate saveContext];
}

@end
