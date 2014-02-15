//
//  SetGradeScaleViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 2/14/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetGradeScaleViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *displayLabels;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *setButton;
@property (strong, nonatomic) IBOutlet UILabel *incrementLabel;
@property (strong, nonatomic) IBOutlet UIStepper *incrementStepper;

- (IBAction)setButtonClicked:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonClicked:(UIBarButtonItem *)sender;
- (IBAction)stepperValueChanged:(UIStepper *)sender;

@end
