//
//  AboutViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 1/27/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)launchWebsite:(id)sender;

@end
