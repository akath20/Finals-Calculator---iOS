//
//  FirstViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 1/25/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "FirstViewController.h"
#import "SharedValues.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void) viewWillAppear:(BOOL)animated {
    if ([[SharedValues allValues] currentCombinedAverage] == -1.0) {
        self.percentAverageTextField.placeholder = @"%";
    } else {
        self.percentAverageTextField.text = [NSString stringWithFormat:@"%.2f", [[SharedValues allValues] currentCombinedAverage]];
    }
    if ([self allFilled]) {
        [self.goButton setEnabled:true];
    } else {
        [self.goButton setEnabled:false];
    }
    

}

- (IBAction)goPushed:(id)sender {
    
    //set the allValues variables to the onscreen values
    [[SharedValues allValues] setCurrentCombinedAverage:[self.percentAverageTextField.text floatValue]];
    [[SharedValues allValues] setFinalWeight:[self.finalWeight.text floatValue]];
    
    //move to next screen
    [self performSegueWithIdentifier:@"goSegue" sender:nil];
}

- (IBAction)textboxEdited:(UITextField *)sender {
    if (![sender.text isEqualToString:@""]) {
        if (sender.tag == 0) {
            firstTextFull = true;
        } else {
            secondTextFull = true;
        }
    } else {
        if (sender.tag == 0) {
            firstTextFull = false;
        } else {
            secondTextFull = false;
        }

    }
    
    
    //check to see if enable button
    if ([self allFilled]) {
        [self.goButton setEnabled:true];
    } else {
        [self.goButton setEnabled:false];
    }
    
}

- (IBAction)segmentSelected:(UISegmentedControl *)sender {
    
    //-1 means nothing selected
    if (sender.selectedSegmentIndex >= 0) {
        segmentSelected = TRUE;
    } else {
        segmentSelected = false;
    }
    
    //check to see if enable button
    if ([self allFilled]) {
        [self.goButton setEnabled:true];
    } else {
        [self.goButton setEnabled:false];
    }
}

- (BOOL)allFilled {
    xCount = 0;
    
    if (firstTextFull) {
        xCount++;
    }
    
    if (secondTextFull) {
        xCount++;
    }
    
    if (segmentSelected) {
        xCount++;
    }
    
    if (xCount == 3) {
        return true;
    } else {
        return false;
    }
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //resign the keyboard when background touched
    [self.percentAverageTextField resignFirstResponder];
    [self.finalWeight resignFirstResponder];
}


















@end
