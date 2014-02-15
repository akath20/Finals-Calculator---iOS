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
}


- (IBAction)sliderValueChanged:(UISlider *)sender {
    //make the labels show the correspoding grade + the added value
    int xCounter = 0;
    for (UILabel *currentLabel in self.displayLabels) {
        NSDictionary *dic = [[SharedValues allValues] gradeScale];
        NSString *str = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:xCounter];
        currentLabel.text = [NSString stringWithFormat:@"%@%%", [dic valueForKey:str]];
        xCounter++;
    }
}

- (IBAction)setButtonClicked:(UIBarButtonItem *)sender {
}

- (IBAction)cancelButtonClicked:(UIBarButtonItem *)sender {
}





@end
