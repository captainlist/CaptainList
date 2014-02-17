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
    [self.landingPageIndex search:query success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
        for (id hit in [result objectForKey:@"hits"]) {
            Beverage *beverage = [[Beverage alloc] init];
            
            beverage.identifier = [hit objectForKey:@"identifier"];
            beverage.name = [hit objectForKey:@"name"];
            beverage.attributedNameString = [self getStringFor:@"name" payload:hit];
            beverage.type = [hit objectForKey:@"type"];
            beverage.attributedTypeString = [self getStringFor:@"type" payload:hit];
            beverage.price = [hit objectForKey:@"price"];
            beverage.rarity = [hit objectForKey:@"rarity"];
            beverage.body = [hit objectForKey:@"body"];
            beverage.intensity = [hit objectForKey:@"intensity"];
            beverage.origin = [hit objectForKey:@"origin"];
            beverage.houseDistillery = [hit objectForKey:@"houseDistillery"];
            beverage.yelpBusinessIds = [hit objectForKey:@"yelpBusinessIds"];
            
            
            if([hit objectForKey:@"age"] != (id)[NSNull null]) {
                beverage.age = [hit objectForKey:@"age"];
            }
            
            if([hit objectForKey:@"alcoholContent"] != (id)[NSNull null]) {
                beverage.alcoholContent = [hit objectForKey:@"alcoholContent"];
            }
            
            if([hit objectForKey:@"flavor"] != (id)[NSNull null]) {
                beverage.flavor = [hit objectForKey:@"flavor"];
                beverage.attributedFlavorString = [self getStringFor:@"flavor" payload:hit];
            }
            
            if([hit objectForKey:@"finish"] != (id)[NSNull null]) {
                beverage.finish = [hit objectForKey:@"finish"];
                beverage.attributedFinishString = [self getStringFor:@"finish" payload:hit];
            }
            
            if([hit objectForKey:@"nose"] != (id)[NSNull null]) {
                beverage.nose = [hit objectForKey:@"nose"];
                beverage.attributedNoseString = [self getStringFor:@"nose" payload:hit];
            }
        
            if([hit objectForKey:@"similarBeverages"] != (id)[NSNull null]) {
                beverage.similarBeverages = [hit objectForKey:@"similarBeverages"];
            }
            
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
