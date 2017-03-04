//
//  LodgingDetailViewController.m
//  Airbnb
//
//  Created by Roselyn on 3/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "LodgingDetailViewController.h"
#import "LodgingMapAnnotation.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WebService.h"
#import "FavoriteLodging.h"

@interface LodgingDetailViewController ()<MKMapViewDelegate,WebServiceProtocol>

@end

@implementation LodgingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake([self.lodging.latitude floatValue], [self.lodging.longitude floatValue]);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 800, 800)];
    adjustedRegion.span.longitudeDelta  = 0.08;
    adjustedRegion.span.latitudeDelta  = 0.08;
    
    [self.mapView setRegion:adjustedRegion animated:NO];
    self.mapView.showsUserLocation = NO;
    
    LodgingMapAnnotation *annotation = [[LodgingMapAnnotation alloc] initWithCoordinate:startCoord];
    annotation.name = self.lodging.name;
    annotation.price =self.lodging.price;
    annotation.title = self.lodging.name;
    [self.mapView addAnnotation:annotation];
    
    self.name.text = self.lodging.name;
    //self.type.text = self.lodging.type;
    self.roomType.text = self.lodging.roomType;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:self.lodging.userImageUrl]
                      placeholderImage:[UIImage imageNamed:@"placeholder_user3"]
                               options:SDWebImageRefreshCached];
    self.ppublicAddress.text = self.lodging.publicAddress;
    self.numberOfGuests.text = [NSString stringWithFormat:@"%@\nguests",self.lodging.numberOfGuests];
    self.numberOfBedrooms.text = [NSString stringWithFormat:@"%@\nbedroom",self.lodging.numberOfBedrooms];
    self.numberOfBeds.text = [NSString stringWithFormat:@"%@\nbeds",self.lodging.numberOfBeds];
    self.numberOfBathrooms.text = [NSString stringWithFormat:@"%@\nbathroom",self.lodging.numberOfBathrooms];
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:self.lodging.imageUrl]
                      placeholderImage:[UIImage imageNamed:@"placeholder_item"]
                               options:SDWebImageRefreshCached];
    self.userImage.layer.masksToBounds=YES;
    self.userImage.layer.cornerRadius=40;
    self.userImage.layer.borderWidth=1;
    self.userImage.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.mapView.frame)+170)];
    
    self.navigationItem.title =self.lodging.type;
    
    if (self.lodging.completeDescription){
        NSLog(@"ya tiene descripcion");
        self.completeDescription.text=self.lodging.completeDescription;
    }else{
        [WebService sharedInstance].myDelegate=self;
        [[WebService sharedInstance] getDetailLodgingFromServer:[self.lodging.id_ integerValue]];
    }
}

- (void)loadDesctiption:(NSString*)description{
    self.lodging.completeDescription=self.completeDescription.text=description;
    [FavoriteLodging updateFavoriteLodging:[self.lodging.id_ integerValue] withDescription:self.lodging.completeDescription];
}

-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent=NO;
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent=YES;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[LodgingMapAnnotation class]]) {
        
        static NSString *reuseId = @"LodgingAnnotationView";
        MKAnnotationView *av = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
        av.image = [UIImage imageNamed:@"pin"];
        if (av == nil){
            av = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        }
        else{
            av.annotation = annotation;
        }
        UIImageView *bgPin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 35)];
        bgPin.image =  [UIImage imageNamed:@"pin"];
        [av addSubview:bgPin];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor darkGrayColor];
        lbl.textAlignment=NSTextAlignmentCenter;
        //lbl.tag = 42;
        [av addSubview:lbl];
        av.canShowCallout = YES;
        av.frame = lbl.frame;
        
        LodgingMapAnnotation *lodgingAnnotation=annotation;
        
        //UILabel *lbl = (UILabel *)[av viewWithTag:42];
        lbl.text = lodgingAnnotation.price;
        
        return av;
    }
    return nil;
}

- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
