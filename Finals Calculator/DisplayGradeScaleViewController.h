//
//  DisplayGradeScaleViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 2/13/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayGradeScaleViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *displayLabels;
@property (strong, nonatomic) IBOutlet UIButton *setValueButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *resetButtonOutlet;


- (IBAction)resetPushed:(UIBarButtonItem *)sender;

@end
