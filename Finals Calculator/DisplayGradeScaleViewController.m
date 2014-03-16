//
//  DisplayGradeScaleViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 2/13/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "DisplayGradeScaleViewController.h"
#import "SharedValues.h"
#import "AppDelegate.h"

@interface DisplayGradeScaleViewController ()

@end

@implementation DisplayGradeScaleViewController



- (void)viewWillAppear:(BOOL)animated {
    
    self.adBanner = SharedAdBannerView;
    
    
    if ([[SharedValues allValues] adLoaded]) {
        [self loadBanner];
    } else {
        [self bannerError];
    }
    
    
    if ([[SharedValues allValues] comingFromResultsView]) {
        //recreate the dictionary so if it's rounded up it will be created as so
       
        [[SharedValues allValues] createDictionary];
        
        
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
    
    //set the labels
    [self updateLabels];
    
    
    //add the iAd Watchers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    

    
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([[SharedValues allValues] comingFromResultsView]) {
        
    
    [[SharedValues allValues] resetDictionary];
    
        
    }
    
    //Cancel iAd Watchers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bannerError" object:nil];
}

- (IBAction)resetPushed:(UIBarButtonItem *)sender {
    
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle:@"Are You Sure?" message:@"Are you sure you want to reset the grade scale back to the default values?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [areYouSure show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (!(buttonIndex == [alertView cancelButtonIndex])){
        
        //if cancel button not clicked, then reset the values and alert the user
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"defaultGradeScaleValues"];
        NSLog(@"\nNSUserDefaults Cleaned Via User Reset");
        
        //set the grad scale values if needed
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"]) {
            //if there isn't anything there (loaded for the first time) then create it
            
            //create the dictionary
            NSMutableDictionary *loadGradeDictionary = [[NSMutableDictionary alloc] initWithCapacity:11];
            
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  92.5] forKey:@"A"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  89.5] forKey:@"A-"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  86.5] forKey:@"B+"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  82.5] forKey:@"B"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  79.5] forKey:@"B-"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  76.5] forKey:@"C+"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  72.5] forKey:@"C"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  69.5] forKey:@"C-"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  66.5] forKey:@"D+"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  62.5] forKey:@"D"];
            [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  59.5] forKey:@"D-"];
            
            [loadGradeDictionary setObject:[NSArray arrayWithObjects:@"A", @"A-", @"B+", @"B", @"B-", @"C+", @"C", @"C-", @"D+", @"D", @"D-", @"F" , nil] forKey:@"gradesArray"];
            
            //set it
            [[NSUserDefaults standardUserDefaults] setObject:loadGradeDictionary forKey:@"defaultGradeScaleValues"];
            
        }
        
        //then load into the SharedValues dictionary for global access throught the program
        [[SharedValues allValues] setGradeScale:[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"]];
        
        
        //reload the view behind
        [self.resetButtonOutlet setEnabled:false];
        [self.setValueButton setEnabled:true];
        [self updateLabels];
        
        
        
        
        
        //then alert the user that it was successful
        UIAlertView *allSetAlert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"The values have been successfully reset!" delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles: nil];
        [allSetAlert show];
    }
    
    
    
    
    
    
}

- (void)updateLabels {
    //make the labels show the correspoding grade
    int xCounter = 0;
    for (UILabel *currentLabel in self.displayLabels) {
        NSDictionary *dic = [[SharedValues allValues] gradeScale];
        NSString *str = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:xCounter];
        currentLabel.text = [NSString stringWithFormat:@"%.2f%%", [[dic valueForKey:str] floatValue]];
        xCounter++;
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
