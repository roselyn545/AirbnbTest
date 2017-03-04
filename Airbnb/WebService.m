//
//  WebService.m
//  Airbnb
//
//  Created by Roselyn on 2/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import "WebService.h"
#import <AFNetworking/AFNetworking.h>
#import "FavoriteLodging.h"
#define limit_rows 30


@implementation WebService

@synthesize lodgingsList;

+(WebService *)sharedInstance
{
    static WebService* webService = nil;
    if(!webService)
        webService = [[WebService alloc] init];
    
    return webService;
}

- (void) loadLodgingsFromServer{
    lodgingsList = [[NSMutableArray alloc]init];
    [self getLodgingsFromServerInPage:0];
}

- (void) getLodgingsFromServerInPage: (int) pag{
    
    NSString *listLodgingsUrl=[NSString stringWithFormat:@"https://api.airbnb.com/v2/search_results?client_id=3092nxybyb0otqw18e8nh5nty&_limit=%i&_offset=%i&location=%@",limit_rows,pag*limit_rows,[LocationManager sharedInstance].city];
    
    listLodgingsUrl = [listLodgingsUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listLodgingsUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"AFHTTPSessionManager url %@",listLodgingsUrl);
        NSLog(@"response %@",[responseObject objectForKey:@"search_results"]);
        
        for (NSDictionary *dict in [responseObject objectForKey:@"search_results"]) {
            FavoriteLodging *fav= [FavoriteLodging getLodgingFromId:[[[dict objectForKey:@"listing"] objectForKey:@"id"] integerValue]];
            [lodgingsList addObject:[RemoteLodging initFromDictionary:dict favorite:(fav && [fav.isFavorite intValue]==1)]];
        }
        
        if ([self.myDelegate respondsToSelector:@selector(listUpdated)]){
            [self.myDelegate listUpdated];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"AFHTTPSessionManager url %@ Error: %@",listLodgingsUrl,error);
        if ([self.myDelegate respondsToSelector:@selector(errorInRequest:error:)]){
            [self.myDelegate errorInRequest:1 error:error];
        }
    }];
}


- (void) getDetailLodgingFromServer:(int64_t)id_{
    
    NSString *detailLodgingsUrl=[NSString stringWithFormat:@"https://api.airbnb.com/v2/listings/%lli?client_id=3092nxybyb0otqw18e8nh5nty&_format=v1_legacy_for_p3",id_];
    
    //detailLodgingsUrl = [detailLodgingsUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:detailLodgingsUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"AFHTTPSessionManager url %@",detailLodgingsUrl);
        
        if ([self.myDelegate respondsToSelector:@selector(loadDesctiption:)]){
            [self.myDelegate loadDesctiption:[[responseObject objectForKey:@"listing"] objectForKey:@"description"]];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"AFHTTPSessionManager url %@ Error: %@",detailLodgingsUrl,error);
        if ([self.myDelegate respondsToSelector:@selector(errorInRequest:error:)]){
            [self.myDelegate errorInRequest:2 error:error];
        }
    }];
}



@end
