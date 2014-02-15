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
    if ([[SharedValues allValues] comingFromResultsView]) {
        //recreate the dictionary so if it's rounded up it will be created as so
        NSLog(@"\n\nDisplay ViewWillAppear before: %@", [[SharedValues allValues] gradeScale]);
        [[SharedValues allValues] createDictionary];
        NSLog(@"\n\nDisplay ViewWillAppear after: %@", [[SharedValues allValues] gradeScale]);
        
        //show setValueButton
        [self.setValueButton setHidden:true];
        [self.resetButtonOutlet setEnabled:false];
        
    } else {
        
        //if coming from the about page
       [self.setValueButton setHidden:false];
        
        
        
        if (!([[[[SharedValues allValues] gradeScale] valueForKey:@"A"] floatValue] == 92.5)) {
            //if the values arn't the original value then enable the reset button and disable the set button
            [self.resetButtonOutlet setEnabled:true];
            [self.setValueButton setEnabled:false];
        } else {
            //if the values are the original ones, disable the reset button and enable the set button
            [self.resetButtonOutlet setEnabled:false];
            [self.setValueButton setEnabled:true];
        }
        
    }
    

    //make the labels show the correspoding grade
    int xCounter = 0;
    for (UILabel *currentLabel in self.displayLabels) {
        NSDictionary *dic = [[SharedValues allValues] gradeScale];
        NSString *str = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:xCounter];
        currentLabel.text = [NSString stringWithFormat:@"%.2f%%", [[dic valueForKey:str] floatValue]];
        xCounter++;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    if ([[SharedValues allValues] comingFromResultsView]) {
        
    NSLog(@"\n\nDisplay ViewWillDisappear before: %@", [[SharedValues allValues] gradeScale]);
    [[SharedValues allValues] resetDictionary];
    NSLog(@"\n\nDisplay ViewWillDisappear after: %@", [[SharedValues allValues] gradeScale]);
        
    }
}

- (IBAction)resetPushed:(UIBarButtonItem *)sender {
}
@end
