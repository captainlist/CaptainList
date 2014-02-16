//
//  SimOrgBeveragesClient.h
//  CaptainList
//
//  Created by abhishek patnia on 2/15/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimOrgBeveragesViewController.h"

@interface SimOrgBeveragesClient : NSObject
- (void)getLandingPageBeveragesWithQuery:(NSString *)beverageQuery yelp:(NSArray *)yelpQuery tableView:(SimOrgBeveragesViewController *) tableView;
@end
