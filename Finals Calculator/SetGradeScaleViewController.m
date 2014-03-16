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
    
    //auto make the set button disabled
    [self.setButton setEnabled:false];
    
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
    
    
    //add the iAd Watchers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
}

- (void)viewDidLoad {
    
    [self.adBanner setHidden:true];
    
    //FIX FOR SCROLLVIEW WITH AUTOLAYOUT
    [self setAutomaticallyAdjustsScrollViewInsets:false];
    [self.mainScrollView setContentSize:CGSizeMake(320, 800)];
    
    //auto reposition so if i edit in IB it will return at runtime
    //y NOT 64 to not have a white space above it
    [self.scrollViewView setFrame:CGRectMake(0, 0, self.scrollViewView.frame.size.width, self.scrollViewView.frame.size.height)];
}

- (void)viewDidLayoutSubviews {
    //FIX FOR SCROLLVIEW WITH AUTOLAYOUT
    [self.mainScrollView setContentSize:CGSizeMake(320, self.scrollViewView.frame.size.height)];
}

- (IBAction)setButtonClicked:(UIBarButtonItem *)sender {
    UIAlertView *confirmAlert = [[UIAlertView alloc] initWithTitle:@"Are You Sure?" message:@"Are you sure that you want to set the grade scale like this?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [confirmAlert show];
    
}

- (IBAction)cancelButtonClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)stepperValueChanged:(UIStepper *)sender {
    
    //enable the set button if the value is not 0
    if (!(sender.value == 0)) {
        [self.setButton setEnabled:true];
    } else {
        [self.setButton setEnabled:false];
    }
    
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

- (void)viewDidDisappear:(BOOL)animated {
    //Cancel iAd Watchers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerError" object:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (!(buttonIndex == [alertView cancelButtonIndex])){
        //if cancel button not clicked, then set the values and alert the user
        
        //create the dictionary
        NSMutableDictionary *loadGradeDictionary = [[NSMutableDictionary alloc] initWithCapacity:11];
        
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (92.5 + self.incrementStepper.value)] forKey:@"A"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (89.5 + self.incrementStepper.value)] forKey:@"A-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (86.5 + self.incrementStepper.value)] forKey:@"B+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (82.5 + self.incrementStepper.value)] forKey:@"B"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (79.5 + self.incrementStepper.value)] forKey:@"B-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (76.5 + self.incrementStepper.value)] forKey:@"C+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (72.5 + self.incrementStepper.value)] forKey:@"C"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (69.5 + self.incrementStepper.value)] forKey:@"C-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (66.5 + self.incrementStepper.value)] forKey:@"D+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (62.5 + self.incrementStepper.value)] forKey:@"D"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (59.5 + self.incrementStepper.value)] forKey:@"D-"];
        
        [loadGradeDictionary setObject:[NSArray arrayWithObjects:@"A", @"A-", @"B+", @"B", @"B-", @"C+", @"C", @"C-", @"D+", @"D", @"D-", @"F" , nil] forKey:@"gradesArray"];
        
        //set the values
        [[NSUserDefaults standardUserDefaults] setObject:loadGradeDictionary forKey:@"defaultGradeScaleValues"];
        [[SharedValues allValues] setGradeScale:[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"]];
        
        //go back to the display screen
        [self dismissViewControllerAnimated:YES completion:^{
            //tell the user that it was successful
            UIAlertView *allSetAlert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"The values have been successfully updated!" delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles: nil];
            [allSetAlert show];
        }];
        
        
   
    }
}

#pragma mark Ads

- (void)loadBanner {
    [self.adBanner setHidden:false];
    
}

- (void)bannerError {
    [self.adBanner setHidden:true];
}



@end
