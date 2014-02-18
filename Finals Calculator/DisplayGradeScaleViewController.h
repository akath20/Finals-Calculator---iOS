//
//  DisplayGradeScaleViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 2/13/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface DisplayGradeScaleViewController : UIViewController <UIAlertViewDelegate> {
    
}
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *displayLabels;
@property (strong, nonatomic) IBOutlet UIButton *setValueButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *resetButtonOutlet;
@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;


- (IBAction)resetPushed:(UIBarButtonItem *)sender;

@end
