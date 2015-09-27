//
//  FourSquareAPIManager.m
//  MapIt
//
//  Created by Justine Gartner on 9/27/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "FourSquareAPIManager.h"
#import <AFNetworking/AFNetworking.h>

#define kFSClientID @"IN4V05KYYXLPDXGIHMCDSPVIAG30BTOG4NC3AEAYFYIQZID0"
#define kFSClientSecret @"CD31L2IZKSYQ1AAGTHQQEF2GHXJLI43CXYV1KVCEEUQZQ2G4"

@implementation FourSquareAPIManager

+ (void)searchFourSquarePlacesForTerm: (NSString *)term
                             location: (CLLocationCoordinate2D)location
                   completionHandler: (void(^)(id response, NSError *error))handler{
    
    /*Please search FourSquare API
     https://api.foursquare.com/v2/venues/search
        ?client_id=CLIENT_ID
        &client_secret=CLIENT_SECRET
        &v=20130815
        &ll=40.7,-74
        &query=sushi*/
    
    NSString *APIBase = @"https://api.foursquare.com";
    NSString *APIVersion = @"v2";
    NSString *APIEndpoint = @"venues/search";
    
    term = [term stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat: @"%@/%@/%@?client_id=%@&client_secret=%@&v=20150927&ll=%f,%f&query=%@", APIBase, APIVersion, APIEndpoint, kFSClientID, kFSClientSecret, location.latitude, location.longitude, term];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        handler(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        handler(nil, error);
    }];
}

@end
