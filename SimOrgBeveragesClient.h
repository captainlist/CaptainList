//
//  SimOrgBeveragesClient.h
//  CaptainList
//
//  Created by abhishek patnia on 2/15/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimOrgBeveragesClient : NSObject
- (NSArray *)getBeveragesWithQuery:(NSDictionary *)beverageQuery yelp:(NSArray *)yelpQuery;

@end
