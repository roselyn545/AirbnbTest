//
//  LocationManager.m
//  Airbnb
//
//  Created by JpcPruebas on 3/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "LocationManager.h"
#import "WebService.h"

@implementation LocationManager

@synthesize city;

+(LocationManager *)sharedInstance
{
    static LocationManager* location = nil;
    if(!location)
        location = [[LocationManager alloc] init];
    
    return location;
}

- (void) getLocation{
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];
}

-(void) test{
    [self loadDataDefault];
    [[WebService sharedInstance] loadLodgingsFromServer];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    [self.manager stopUpdatingLocation];
    self.manager.delegate = nil;
    
    //[self test];
    //return;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks lastObject];
             
             NSLog(@"placemarks %@",placemark);
             // strAdd -> take bydefault value nil
             city = nil;
             
             if ([placemark.locality length] != 0)
             {
                 city = placemark.locality;
                 if ([placemark.country length] != 0)
                 {
                     city = [NSString stringWithFormat:@"%@, %@",city,[placemark country]];
                 }
                 
                 CLLocation *newLocation = [locations lastObject];
                 self.myPosition=newLocation;

             }else{
                 [self loadDataDefault];
             }
             
         }else{
             [self loadDataDefault];
         }
         
         if ([self.myDelegate respondsToSelector:@selector(updateLocation:)]){
             [self.myDelegate updateLocation:self.city];
         }
         [[WebService sharedInstance] loadLodgingsFromServer];

         NSLog(@"city %@",city);
     }];
}

-(void) loadDataDefault{
    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:34.042572 longitude:-118.2683212];
    self.myPosition=newLocation;
    city = @"Los Angeles, CA, USA";
}

@end
