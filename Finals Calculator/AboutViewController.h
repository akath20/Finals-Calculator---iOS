//
//  AboutViewController.h

//
//  Created by Alex Atwater on 1/27/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <MessageUI/MessageUI.h>

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) ADBannerView *adBanner;

- (IBAction)launchWebsite:(id)sender;
- (IBAction)sendDevEmail:(UIButton *)sender;

@end
