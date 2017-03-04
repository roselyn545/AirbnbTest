//
//  SecondViewController.m
//  Airbnb
//
//  Created by Roselyn on 1/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "MapViewController.h"
#import "LodgingMapAnnotation.h"
#import "LocationManager.h"
#import "WebService.h"
#import "LodgingDetailViewController.h"

@interface MapViewController ()<WebServiceProtocol>

@property (nonatomic) UIButton *buttonIrAPosicion;
@property (nonatomic) LocationManager *LM;
@property (nonatomic) WebService* WS;

@end

@implementation MapViewController

@synthesize WS;
@synthesize LM;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(zoomToUserLocation)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[UIImage imageNamed:@"current_location"] forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width-55, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-70, 35, 35);
    button.contentMode=UIViewContentModeCenter;
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    button.imageEdgeInsets=UIEdgeInsetsMake(5, 5, 5, 5);
    button.backgroundColor=[UIColor colorWithRed:60/255.0 green:213/255.0 blue: 201/255.0 alpha:1];
    
    self.buttonIrAPosicion=button;
    [self.view addSubview:self.buttonIrAPosicion];
    
    LM = [LocationManager sharedInstance];
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(LM.myPosition.coordinate.latitude, LM.myPosition.coordinate.longitude);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 800, 800)];
    adjustedRegion.span.longitudeDelta  = 0.07;
    adjustedRegion.span.latitudeDelta  = 0.07;
    
    [self.mapView setRegion:adjustedRegion animated:NO];
    self.mapView.showsUserLocation = YES;
    [self.view bringSubviewToFront:self.buttonIrAPosicion];

    WS = [WebService sharedInstance];
    WS.myDelegate = self;
    
    [self addLodgings];
}

-(void) listUpdated{
    NSLog(@"debo actualizar el mapa");
    [self addLodgings];
}

-(void) addLodgings{
    for (RemoteLodging *rl in WS.lodgingsList){
        //NSLog(@"latitud %f longitud %f",rl.latitude ,rl.longitude);
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:[rl.latitude floatValue] longitude:[rl.longitude floatValue]];
        LodgingMapAnnotation *annotation = [[LodgingMapAnnotation alloc] initWithCoordinate:loc.coordinate];
        annotation.name = rl.name;
        annotation.price = rl.price;
        annotation.title = rl.name;
        annotation.id_ = [rl.id_ integerValue];
        [self.mapView addAnnotation:annotation];
    }
}

-(void)zoomToUserLocation{
    if (self.mapView!=nil){
        MKCoordinateRegion mapRegion;
        mapRegion.center = self.mapView.userLocation.coordinate;
        mapRegion.span.latitudeDelta = 0.07;
        mapRegion.span.longitudeDelta = 0.07;
        
        [self.mapView setRegion:mapRegion animated: YES];
    }
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

-(void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(nonnull MKAnnotationView *)view{
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[LodgingMapAnnotation class]] )
    {
        LodgingMapAnnotation *lodgingAnnotation=view.annotation;
        
        RemoteLodging *selected = nil;
        for (RemoteLodging *rl in WS.lodgingsList){
            if (lodgingAnnotation.id_ == [rl.id_ integerValue]){
                selected = rl;
                break;
            }
        }
        [mapView deselectAnnotation:view.annotation animated:YES];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LodgingDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"lodging_detail"];
        vc.lodging = selected;
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
