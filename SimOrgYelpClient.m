//
//  SimOrgYelpClient.m
//  CaptainList
//
//  Created by Vaibhav Shankar on 2/15/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import "SimOrgYelpClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"

@implementation SimOrgYelpClient

NSString * const BASE_YELP_URL= @"http://api.yelp.com/business_review_search?category=bars&location=%@&ywsid=ySre-weULofLkv_i3kND_w";

NSString * const BASE_YELP_URL_V2= @"http://api.yelp.com/v2/search";

NSString *const YELP_CONSUMER = @"JgATHisKwbRC3Uu0Ld1YVw";
NSString *const YELP_CONSUMER_SECRET = @"MaHx6V9VYHfQoDUMT2RjWAgHxYE";

NSString *const YELP_TOKEN = @"SUgpownwlKQzfkp-oLxuWPXc8-XhUFd0";
NSString *const YELP_TOKEN_SECRET = @"fpXf_sUOxcSvewZdj-4TMHkjOm0";

SimOrgBeveragesViewController * myView;

+(void) findByLocation:(NSString *)location view:(SimOrgBeveragesViewController *)view
{
    NSString* url = [NSString stringWithFormat:BASE_YELP_URL,location];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
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

-(void) findByLocationV2:(NSString *)location view:(SimOrgBeveragesViewController *)view
{
    myView = view;
    NSURL *url = [NSURL URLWithString:BASE_YELP_URL_V2];
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:YELP_CONSUMER secret:YELP_CONSUMER_SECRET];
    OAToken *token = [[OAToken alloc] initWithKey:YELP_TOKEN secret:YELP_TOKEN_SECRET];
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url consumer:consumer token:token realm:nil signatureProvider:[[OAHMAC_SHA1SignatureProvider alloc] init]];
    OARequestParameter *categoryParam = [[OARequestParameter alloc] initWithName:@"category_filter" value:@"bars"];
    OARequestParameter *locationParam = [[OARequestParameter alloc] initWithName:@"location" value:location];
    NSArray *params = [NSArray arrayWithObjects:categoryParam, locationParam, nil];
    [request setParameters:params];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(searchTicket:didFinishWithData:)
                didFailSelector:@selector(searchTicket:didFailWithError:)];
    
}

-(void)searchTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSArray *bars = [parsedObject valueForKey:@"businesses"];
    for (NSDictionary *resultObject in bars) {
        [ret addObject:[SimOrgYelpResult makeResult:resultObject]];
    }
    myView.yelpResults = ret;
    [myView refreshControl];
    
    for (SimOrgYelpResult *res in myView.yelpResults) {
        NSLog(@"%@", [res name]);
    }
}

-(void)searchTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)data {
    NSLog(@"%@", data);
}
@end
