//
//  WebService.h
//  Airbnb
//
//  Created by Roselyn on 2/3/17.
//  Copyright © 2017 Roselyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteLodging.h"
#import "LocationManager.h"


@protocol WebServiceProtocol <NSObject>
-(void) listUpdated;
-(void)loadDesctiption:(NSString*)description;
-(void) errorInRequest:(int)request error:(NSError*)error;
@end

@interface WebService : NSObject

@property (nonatomic) NSMutableArray *lodgingsList;
@property (nonatomic,weak) id <WebServiceProtocol> myDelegate;

+(WebService *)sharedInstance;
- (void) loadLodgingsFromServer;
- (void) getLodgingsFromServerInPage: (int) pag;
- (void) getDetailLodgingFromServer:(int64_t)id_;

@end
