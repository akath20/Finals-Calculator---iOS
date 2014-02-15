//
//  SetGradeScaleViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 2/14/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "SetGradeScaleViewController.h"
#import "SharedValues.h"

@interface SetGradeScaleViewController ()

@end

@implementation SetGradeScaleViewController


- (void)viewWillAppear:(BOOL)animated {
    
    //make the labels show the correspoding grade
    int xCounter = 0;
    for (UILabel *currentLabel in self.displayLabels) {
        NSDictionary *dic = [[SharedValues allValues] gradeScale];
        NSString *str = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:xCounter];
        currentLabel.text = [NSString stringWithFormat:@"%@%%", [dic valueForKey:str]];
        xCounter++;
    }
    
    //set the stepper label just in case
    self.incrementLabel.text = [NSString stringWithFormat:@"%.1f", self.incrementStepper.value];
}

- (IBAction)setButtonClicked:(UIBarButtonItem *)sender {
}

- (IBAction)cancelButtonClicked:(UIBarButtonItem *)sender {
}

- (IBAction)stepperValueChanged:(UIStepper *)sender {
    
    //update the labels to show the correspoding grade from the stepper change
    int xCounter = 0;
    for (UILabel *currentLabel in self.displayLabels) {
        NSDictionary *dic = [[SharedValues allValues] gradeScale];
        NSString *str = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:xCounter];
        currentLabel.text = [NSString stringWithFormat:@"%.2f%%", ([[dic valueForKey:str] floatValue] + sender.value)];
        xCounter++;
    }
    
    //update the label
    if (sender.value > 0) {
        self.incrementLabel.text = [NSString stringWithFormat:@"+ %.1f", sender.value];
    } else if (sender.value == 0.0) {
        self.incrementLabel.text = [NSString stringWithFormat:@"%.1f", sender.value];
    } else {
        self.incrementLabel.text = [NSString stringWithFormat:@"%.1f", sender.value];
    }
    
}





@end
