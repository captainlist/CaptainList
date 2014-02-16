//
//  SimOrgBeveragesViewController.h
//  CaptainList
//
//  Created by abhishek patnia on 2/12/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimOrgBeveragesViewController : UITableViewController<UISearchDisplayDelegate, UISearchBarDelegate>

@property  NSString *location;
@property NSArray *beverages;

@end
