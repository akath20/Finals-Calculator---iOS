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
#import "AppDelegate.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    
    //set the current version number
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
    [self.adBanner setHidden:true];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.adBanner = SharedAdBannerView;
    //add the iAd Watchers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    //Cancel iAd Watchers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerError" object:nil];
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

#pragma mark Ads

- (void)loadBanner {
    [self.adBanner setHidden:false];
    
}

- (void)bannerError {
    [self.adBanner setHidden:true];
}




@end
