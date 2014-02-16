//
//  Beverage.h
//  CaptainList
//
//  Created by abhishek patnia on 2/13/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beverage : NSObject

@property NSString *identifier;
@property NSString *name;
@property NSString *type;
@property NSString *price;
@property NSString *rarity;
@property NSString *body;
@property NSString *flavor;
@property NSString *finish;
@property NSString *nose;
@property NSString *intensity;
@property NSString *origin;
@property NSString *houseDistillery;
@property NSArray *yelpBusinessIds;
@property NSArray *similarBeverages;

@end
