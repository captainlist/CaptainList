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
        [ASAPIClient apiClientWithApplicationID:@"UH6H8NXOF3" apiKey:@"e3d6c06f766618601dee29d8a509ce8b"];
        self.landingPageIndex = [apiClient getIndex:@"landing_beverages"];
        self.fullIndex = [apiClient getIndex:@"beverages"];
    }
    return self;
}

- (void)getLandingPageBeveragesWithQuery:(NSString *)beverageQuery yelp:(NSArray *)yelpQuery tableView:(SimOrgBeveragesViewController *) tableView  {
    NSMutableArray *beverages = [[NSMutableArray alloc] init];
    ASQuery* query = [ASQuery queryWithFullTextQuery:beverageQuery];
    query.hitsPerPage = 8;
    [self.landingPageIndex search:query success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
        for (id hit in [result objectForKey:@"hits"]) {
            Beverage *beverage = [[Beverage alloc] init];
            beverage.identifier = [hit objectForKey:@"Identifier"];
            beverage.name = [hit objectForKey:@"Name"];
            beverage.type = [hit objectForKey:@"Type"];
            beverage.price = [hit objectForKey:@"Price"];
            beverage.rarity = [hit objectForKey:@"Rarity"];
            beverage.body = [hit objectForKey:@"Body"];
            beverage.flavor = [hit objectForKey:@"Flavor"];
            beverage.finish = [hit objectForKey:@"Finish"];
            beverage.nose = [hit objectForKey:@"Nose"];
            beverage.intensity = [hit objectForKey:@"Intensity"];
            beverage.origin = [hit objectForKey:@"Origin"];
            beverage.houseDistillery = [hit objectForKey:@"House Distillery"];
            beverage.yelpBusinessIds = [[hit objectForKey:@"Bars"] componentsSeparatedByString:@","];
            beverage.similarBeverages = [[hit objectForKey:@"YMAL"] componentsSeparatedByString:@","];
            
            [beverages addObject:beverage];
        }
        tableView.beverages = beverages;
        [tableView.tableView reloadData];
    } failure:^(ASRemoteIndex *index, ASQuery *query, NSString *errorMessage) {
        NSLog(errorMessage);
    }];
}

@end
