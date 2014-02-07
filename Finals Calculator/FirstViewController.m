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
    
    
    
    //Set up the dictionary of the grade scale
    //create
    NSMutableDictionary *loadGradeDictionary = [[NSMutableDictionary alloc] initWithCapacity:11];
    
    //load values OVERRIDE USER GIVEN VALUES HERE
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 92.5] forKey:@"A"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 89.5] forKey:@"A-"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 86.5] forKey:@"B+"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 82.5] forKey:@"B"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 79.5] forKey:@"B-"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 76.5] forKey:@"C+"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 72.5] forKey:@"C"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 69.5] forKey:@"C-"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 66.5] forKey:@"D+"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 62.5] forKey:@"D"];
    [loadGradeDictionary setObject:[NSString stringWithFormat:@"%f", 59.5] forKey:@"D-"];
    
    //also set a NSArray to be able to loop through the grades reliably
    [loadGradeDictionary setObject:[NSArray arrayWithObjects:@"A", @"A-", @"B+", @"B", @"B-", @"C+", @"C", @"C-", @"D+", @"D", @"D-", @"F" , nil] forKey:@"gradesArray"];
    
    //set the dictionary in sharedValues
    [[SharedValues allValues] setGradeScale:loadGradeDictionary];
    
    
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
    
    //MAKE IT A DECIMAL
    [[SharedValues allValues] setFinalWeight:([self.finalWeight.text floatValue]/100)];
    
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
        [sender setText:[NSString stringWithFormat:@"%.2f", [sender.text floatValue]]];
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

- (IBAction)editingEndedTextbox:(id)sender {
    //modify the text box to have a % symbol in there
    //add later?
    
}

















@end
