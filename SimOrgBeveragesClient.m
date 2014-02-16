//
//  SimOrgBeveragesClient.m
//  CaptainList
//
//  Created by abhishek patnia on 2/15/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import "SimOrgBeveragesClient.h"
#import "ASAPIClient.h"
#import "Beverage.h"

@interface SimOrgBeveragesClient ()
@property ASRemoteIndex *landingPageIndex;
@property ASRemoteIndex *fullIndex;
@end

@implementation SimOrgBeveragesClient

- (id)init
{
    self = [super init];
    if (self) {
        ASAPIClient *apiClient =
        
        self.landingPageIndex = [apiClient getIndex:@"landing_beverages"];
        self.fullIndex = [apiClient getIndex:@"beverages"];
    }
    return self;
}

- (NSArray *)getLandingPageBeveragesWithQuery:(NSString *)beverageQuery yelp:(NSArray *)yelpQuery beverages:(NSMutableArray **) beverages {
    ASQuery* query = [ASQuery queryWithFullTextQuery:beverageQuery];
    [self.landingPageIndex search:query success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
        for (id hit in [result objectForKey:@"hits"]) {
            Beverage *beverage = [[Beverage alloc] init];
            beverage.Name = [hit objectForKey:@"Name"];
            NSLog(beverage.Name);
            [*beverages addObject:beverage];
        }
    } failure:^(ASRemoteIndex *index, ASQuery *query, NSString *errorMessage) {
        NSLog(errorMessage);
    }];
    
    return *beverages;
}

@end
