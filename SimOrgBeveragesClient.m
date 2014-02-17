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
    if(!beverageQuery || [beverageQuery length] == 0) {
        return;
    }
    
    NSMutableArray *beverages = [[NSMutableArray alloc] init];
    ASQuery* query = [ASQuery queryWithFullTextQuery:beverageQuery];
    query.queryType = @"prefixAll";
    [self.landingPageIndex search:query success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
        for (id hit in [result objectForKey:@"hits"]) {
            Beverage *beverage = [[Beverage alloc] init];
            
            beverage.identifier = [hit objectForKey:@"Identifier"];
            
            beverage.name = [hit objectForKey:@"Name"];
            beverage.attributedNameString = [self getStringFor:@"Name" payload:hit];
            
            beverage.type = [hit objectForKey:@"Type"];
            beverage.attributedTypeString = [self getStringFor:@"Type" payload:hit];

            beverage.price = [hit objectForKey:@"Price"];
            beverage.rarity = [hit objectForKey:@"Rarity"];
            beverage.body = [hit objectForKey:@"Body"];
            
            if(![[hit objectForKey:@"Age"] isKindOfClass:[NSString class]]) {
                beverage.age = [hit objectForKey:@"Age"];
            }
            
            if(![[hit objectForKey:@"AlcoholContent"]  isKindOfClass:[NSString class]]) {
                beverage.alcoholContent = [hit objectForKey:@"AlcoholContent"];
            }
            
            
            
            beverage.flavor = [hit objectForKey:@"Flavor"];
            beverage.attributedFlavorString = [self getStringFor:@"Flavor" payload:hit];
            
            beverage.finish = [hit objectForKey:@"Finish"];
            beverage.attributedFinishString = [self getStringFor:@"Finish" payload:hit];

            beverage.nose = [hit objectForKey:@"Nose"];
            beverage.attributedNoseString = [self getStringFor:@"Nose" payload:hit];
            beverage.intensity = [hit objectForKey:@"Intensity"];
            beverage.origin = [hit objectForKey:@"Origin"];
            beverage.houseDistillery = [hit objectForKey:@"House Distillery"];
            beverage.yelpBusinessIds = [[hit objectForKey:@"Bars"] componentsSeparatedByString:@","];
            beverage.similarBeverages = [[hit objectForKey:@"YMAL"] componentsSeparatedByString:@","];
            
            [beverages addObject:beverage];
        }
        
        
        tableView.beverages = beverages;
        [tableView.tableView reloadData];
        [tableView.searchDisplayController.searchResultsTableView reloadData];
    } failure:^(ASRemoteIndex *index, ASQuery *query, NSString *errorMessage) {
        NSLog(errorMessage);
    }];
}

-(NSAttributedString *) getStringFor:(NSString *) attributeName payload:(NSDictionary *) payload{
     NSString *markedupString = [[[payload objectForKey:@"_highlightResult"] objectForKey:attributeName] objectForKey:@"value"];
    NSString *value = [payload objectForKey:attributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value];
    
    if(!markedupString) {
        return attributedString;
    }
    
    int location;
    int length;
    
    int startsSeen = 0;
    int endsSeen = 0;
    
    for(int i=0; i<[markedupString length]; i++) {
        if(i+5 > [markedupString length]) {
            break;
        }
        
        if([[markedupString substringWithRange:NSMakeRange(i, 4)] isEqualToString:@"<em>"]) {
            location = i -startsSeen*4 - endsSeen*5;
            startsSeen++;
        }
        
        if([[markedupString substringWithRange:NSMakeRange(i, 5)] isEqualToString:@"</em>"]) {
            endsSeen++;
            length = i +5;
            length = length -startsSeen*4 - endsSeen*5 - location;
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleThick] range:NSMakeRange(location, length)];
        }
    }
    
    
    return attributedString;
 }
@end
