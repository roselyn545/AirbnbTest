//
//  LodgingMapAnnotation.m
//  Airbnb
//
//  Created by JpcPruebas on 3/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "LodgingMapAnnotation.h"

@implementation LodgingMapAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    
    if (self != nil) {
        self.coordinate = coordinate;
    }
    
    return self;
}

- (MKMapItem*)mapItem {
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate]; /*
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];*/
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end
