//
//  SetGradeScaleViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 2/14/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetGradeScaleViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *displayLabels;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *setButton;


- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)setButtonClicked:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonClicked:(UIBarButtonItem *)sender;

@end
