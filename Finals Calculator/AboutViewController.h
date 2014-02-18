//
//  AboutViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 1/27/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface AboutViewController : UIViewController <ADBannerViewDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;

- (IBAction)launchWebsite:(id)sender;

@end
