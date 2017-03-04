//
//  LodgingDetailViewController.h
//  Airbnb
//
//  Created by Roselyn on 3/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RemoteLodging.h"

@interface LodgingDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBedrooms;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBeds;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBathrooms;
@property (weak, nonatomic) IBOutlet UILabel *numberOfGuests;
@property (weak, nonatomic) IBOutlet UILabel *roomType;
@property (weak, nonatomic) IBOutlet UITextView *completeDescription;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *ppublicAddress;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *type;

@property (nonatomic) RemoteLodging *lodging;

- (IBAction)pop:(id)sender;


@end
