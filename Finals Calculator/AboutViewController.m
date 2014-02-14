//
//  AboutViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 1/27/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    
    //set the current version number
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    
}

- (IBAction)launchWebsite:(id)sender {
    //open my website
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"www.webpages.charter.net/akath20"]];
}
@end
