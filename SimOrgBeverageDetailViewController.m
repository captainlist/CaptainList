//
//  SimOrgBeverageDetailViewController.m
//  CaptainList
//
//  Created by abhishek patnia on 2/16/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import "SimOrgBeverageDetailViewController.h"

@interface SimOrgBeverageDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *rarity;
@property (weak, nonatomic) IBOutlet UILabel *origin;

@end

@implementation SimOrgBeverageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.name.text = self.beverage.name;
    self.type.text = self.beverage.type;
    self.price.text = self.beverage.price;
    self.rarity.text = self.beverage.rarity;
    self.origin.text = self.beverage.origin;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
