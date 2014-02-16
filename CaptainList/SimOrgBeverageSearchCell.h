//
//  SimOrgBeverageSearchCell.h
//  CaptainList
//
//  Created by abhishek patnia on 2/16/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimOrgBeverageSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *nose;
@property (weak, nonatomic) IBOutlet UILabel *flavor;
@property (weak, nonatomic) IBOutlet UILabel *finish;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *rarity;

@end
