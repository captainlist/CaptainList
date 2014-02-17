//
//  SimOrgLandingPageViewController.m
//  CaptainList
//
//  Created by abhishek patnia on 2/12/14.
//  Copyright (c) 2014 SimOrg. All rights reserved.
//

#import "SimOrgLandingPageViewController.h"
#import "SimOrgBeveragesViewController.h"
#import "SimOrgYelpClient.h"

@interface SimOrgLandingPageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@end


@implementation SimOrgLandingPageViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SimOrgBeveragesViewController *beverageViewController = segue.destinationViewController;
    
    if(self.locationTextField.text.length > 0) {
        beverageViewController.location = self.locationTextField.text;
        [SimOrgYelpClient findByLocation:self.locationTextField.text view:beverageViewController];
    }
}


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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
