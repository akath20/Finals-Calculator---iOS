//
//  AboutViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 1/27/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "AboutViewController.h"
#import "DisplayGradeScaleViewController.h"
#import "SharedValues.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    
    //set the current version number
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    
}

- (IBAction)launchWebsite:(id)sender {
    //open my website
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://webpages.charter.net/akath20/"]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCurrentGradeScale"]) {
        [[SharedValues allValues] setComingFromResultsView:false];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[SharedValues allValues] setComingFromResultsView:false];
}

@end
