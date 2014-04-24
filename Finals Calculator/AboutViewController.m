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
#import <sys/utsname.h>

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    
    //set the current version number
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.adBanner = SharedAdBannerView;
    //add the iAd Watchers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    
    if ([[SharedValues allValues] adLoaded]) {
        [self loadBanner];
    } else {
        [self bannerError];
    }
    
    [self.view addSubview:self.adBanner];
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


#pragma  mark Email

- (IBAction)sendDevEmail:(UIButton *)sender {
    
    
    MFMailComposeViewController *emailSheet = [[MFMailComposeViewController alloc] init];
    
    emailSheet.mailComposeDelegate = self;
    
    // Fill out the email body text.
    
    //get the device type
    //*IMPORT* <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    
    NSString *emailBody = [NSString stringWithFormat:@"\n\r\n\r\n\riOS Version: %@\n\rDevice: %@\n\rApp Version: %@\n\rApp Name: %@", [[UIDevice currentDevice] systemVersion], deviceType, [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"], [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    [emailSheet setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentViewController:emailSheet animated:true completion:nil];
    
    
    
    
    
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:true completion:nil];
}



@end
