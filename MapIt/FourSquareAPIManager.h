//
//  FourSquareAPIManager.h
//  MapIt
//
//  Created by Justine Gartner on 9/27/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FourSquareAPIManager : NSObject

+ (void)searchFourSquarePlacesForTerm: (NSString *)term
                             location: (CLLocationCoordinate2D)location
                    completionHandler: (void(^)(id response, NSError *error))handler;

@end
