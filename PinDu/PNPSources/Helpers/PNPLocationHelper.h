//
//  PNPLocationHelper.h
//  PNP
//
//  Created by lianhai on 14-8-21.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^DidGetGeolocationsCompledBlock)(NSArray *placemarks);

@interface PNPLocationHelper : NSObject

- (void)getCurrentGeolocationsCompled:(DidGetGeolocationsCompledBlock)compled;

@end
