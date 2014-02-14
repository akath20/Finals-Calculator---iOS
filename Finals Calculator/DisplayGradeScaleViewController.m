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
        NSDictionary *dic = [[SharedValues allValues] gradeScale];
        NSString *str = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:xCounter];
        currentLabel.text = [NSString stringWithFormat:@"%@%%", [dic valueForKey:str]];
        xCounter++;
    }
}

@end
