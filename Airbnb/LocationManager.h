//
//  LocationManager.h
//  Airbnb
//
//  Created by JpcPruebas on 3/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerProtocol <NSObject>
-(void) updateLocation:(NSString*)city ;
@end

@interface LocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic) NSString *city;
@property (strong, nonatomic) CLLocationManager *manager;
@property (nonatomic) CLLocation *myPosition;
@property (nonatomic,weak) id <LocationManagerProtocol> myDelegate;

+(LocationManager *)sharedInstance;
- (void) getLocation;

@end
