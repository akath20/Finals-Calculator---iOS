//
//  DisplayGradeScaleViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 2/13/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "DisplayGradeScaleViewController.h"
#import "SharedValues.h"

@interface DisplayGradeScaleViewController ()

@end

@implementation DisplayGradeScaleViewController

- (void)viewWillAppear:(BOOL)animated {
    //make the labels show the correspoding grade
    int xCounter = 0;
    for (UILabel *currentLabel in self.displayLabels) {
        currentLabel.text = [NSString stringWithFormat:@"%@%%", [[[SharedValues allValues] gradeScale] valueForKey:[[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:xCounter]]];
    }
}

@end
