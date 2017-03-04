//
//  LodgingMapAnnotation.h
//  Airbnb
//
//  Created by JpcPruebas on 3/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LodgingMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSString *price;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) int64_t id_;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate ;

@end
