//
//  SimOrgYelpClient.m
//  CaptainList
//
//  Created by Vaibhav Shankar on 2/15/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import "SimOrgYelpClient.h"
#import "AFHTTPRequestOperationManager.h"
@implementation SimOrgYelpClient

NSString * const BASE_YELP_URL= @"http://api.yelp.com/business_review_search?category=bars&location=%@&ywsid=ySre-weULofLkv_i3kND_w";

+(void) findByLocation:(NSString *)location view:(SimOrgBeveragesViewController *)view
{
    NSString* url = [NSString stringWithFormat:BASE_YELP_URL,location];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSMutableArray *ret = [[NSMutableArray alloc] init];
        NSDictionary *parsedObject = (NSDictionary *) responseObject;
        NSArray *bars = [parsedObject valueForKey:@"businesses"];
        for (NSDictionary *resultObject in bars) {
            [ret addObject:[SimOrgYelpResult makeResult:resultObject]];
        }
        view.yelpResults = ret;
        [view refreshControl];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
