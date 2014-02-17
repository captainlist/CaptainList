//
//  SimOrgYelpResult.m
//  CaptainList
//
//  Created by Vaibhav Shankar on 2/15/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import "SimOrgYelpResult.h"
/*
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

 */

/*
 {'address1': '466 Haight St',
 'address2': '',
 'address3': '',
 'avg_rating': 4.0,
 'city': 'San Francisco',
 'distance': 1.8780401945114136,
 'id': 'yyqwqfgn1ZmbQYNbl7s5sQ',
 'is_closed': False,
 'mobile_url': 'http://mobile.yelp.com/biz/yyqwqfgn1ZmbQYNbl7s5sQ',
 'name': 'Nickies',
 'nearby_url': 'http://yelp.com/search?find_loc=466+Haight+St%2C+San+Francisco%2C+CA',
 'neighborhoods': [{'name': 'Hayes Valley',
 'url': 'http://yelp.com/search?find_loc=Hayes+Valley%2C+San+Francisco%2C+CA'}],
 'phone': '4152550300',
 'photo_url': 'http://static.ak.yelp.com/bpthumb/mPNTiQm5HVqLLcUi8XrDiA/ms',
 'photo_url_small': 'http://static.ak.yelp.com/bpthumb/mPNTiQm5HVqLLcUi8XrDiA/ss',
 'rating_img_url': 'http://static.ak.yelp.com/static/20070816/img/ico/stars/stars_4.png',
 'rating_img_url_small': 'http://static.ak.yelp.com/static/20070816/img/ico/stars/stars_small_4.png',
 'review_count': 32
 }
  */
@implementation SimOrgYelpResult
+(SimOrgYelpResult *) makeResult:(NSDictionary *)yelp_result
{
    SimOrgYelpResult *result = [SimOrgYelpResult alloc];
    [result setValue:[yelp_result valueForKey:@"id"] forKey:@"yelp_id"];
    [result setValue:[yelp_result valueForKey:@"name"] forKey:@"name"];
    [result setValue:[yelp_result valueForKey:@"distance"] forKey:@"distance"];
    [result setValue:[yelp_result valueForKey:@"mobile_url"] forKey:@"mobile_url"];
    [result setValue:[yelp_result valueForKey:@"avg_rating"] forKey:@"avg_rating"];
    [result setValue:[yelp_result valueForKey:@"review_count"] forKey:@"num_reviews"];
    [result setValue:[yelp_result valueForKey:@"address1"] forKey:@"address_line_one"];
    [result setValue:[yelp_result valueForKey:@"address2"] forKey:@"address_line_two"];
    [result setValue:[yelp_result valueForKey:@"address3"] forKey:@"address_line_three"];
    [result setValue:[yelp_result valueForKey:@"phone"] forKey:@"phone_number"];
    return result;
}
@end
