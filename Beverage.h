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
@property NSAttributedString *attributedNameString;
@property NSString *type;
@property NSAttributedString *attributedTypeString;
@property NSString *price;
@property NSString *rarity;
@property NSString *body;
@property NSString *flavor;
@property NSAttributedString *attributedFlavorString;
@property NSString *finish;
@property NSAttributedString *attributedFinishString;
@property NSString *nose;
@property NSAttributedString *attributedNoseString;
@property NSNumber *age;
@property NSNumber *alcoholContent;
@property NSString *intensity;
@property NSString *origin;
@property NSString *houseDistillery;
@property NSArray *yelpBusinessIds;
@property NSArray *similarBeverages;

@end
