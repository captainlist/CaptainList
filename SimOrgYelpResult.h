//
//  SimOrgYelpResult.h
//  CaptainList
//
//  Created by Vaibhav Shankar on 2/15/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimOrgYelpResult : NSObject
@property NSString* yelp_id;
@property NSString* name;
@property NSNumber* distance;
@property NSURL* mobile_url;
@property NSNumber* avg_rating;
@property NSNumber* num_reviews;
@property NSString* address_line_one;
@property NSString* address_line_two;
@property NSString* address_line_three;
@property NSString* phone_number;

+(SimOrgYelpResult *) makeResult:(NSDictionary *) yelp_result;
@end
