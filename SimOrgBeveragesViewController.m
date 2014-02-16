//
//  SimOrgBeveragesViewController.m
//  CaptainList
//
//  Created by abhishek patnia on 2/12/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import "SimOrgBeveragesViewController.h"
#import "SimOrgBeverageDetailViewController.h"
#import "SimOrgBeveragesClient.h"
#import "Beverage.h"

@interface SimOrgBeveragesViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *beveragesSearchBar;
@end

@implementation SimOrgBeveragesViewController

+(SimOrgBeveragesClient*) BEVERAGES_CLIENT
{
    static SimOrgBeveragesClient* beveragesClient = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        beveragesClient = [[SimOrgBeveragesClient alloc] init];
    });
    
    return beveragesClient;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [[SimOrgBeveragesViewController BEVERAGES_CLIENT] getLandingPageBeveragesWithQuery:searchText yelp:nil tableView: self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.beverages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"beverageCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Beverage *beverage = [self.beverages objectAtIndex:indexPath.row];
    
    ((UILabel *)[cell viewWithTag:1]).attributedText = beverage.attributedNameString;
    ((UILabel *)[cell viewWithTag:2]).attributedText = beverage.attributedTypeString;
    ((UILabel *)[cell viewWithTag:3]).attributedText = beverage.attributedNoseString;
    ((UILabel *)[cell viewWithTag:4]).attributedText = beverage.attributedFlavorString;
    ((UILabel *)[cell viewWithTag:5]).attributedText = beverage.attributedFinishString;
    ((UILabel *)[cell viewWithTag:6]).text = beverage.price;
    ((UILabel *)[cell viewWithTag:7]).text = beverage.rarity;
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 83;
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.searchDisplayController.isActive) {
        [self performSegueWithIdentifier:@"showBeverageDetail" sender:self];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showBeverageDetail"]) {
        NSIndexPath *indexPath = nil;
        Beverage *beverage = nil;
        
        if(self.searchDisplayController.isActive) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        }else{
            indexPath = [self.tableView indexPathForSelectedRow];
        }
        beverage = [self.beverages objectAtIndex:indexPath.row];
        [[segue destinationViewController] setBeverage:beverage];
    }
}

@end
