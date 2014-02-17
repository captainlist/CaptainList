//
//  SimOrgYelpClient.h
//  CaptainList
//
//  Created by Vaibhav Shankar on 2/15/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import "SimOrgYelpResult.h"
#import "SimOrgBeveragesViewController.h";
#import <Foundation/Foundation.h>

@interface SimOrgYelpClient : NSObject
+(void) findByLocation:(NSString *) location view:(SimOrgBeveragesViewController *) view;
@end
