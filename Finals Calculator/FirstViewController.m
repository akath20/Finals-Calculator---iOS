//
//  FirstViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 1/25/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "FirstViewController.h"
#import "ValuesObject.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void) viewWillAppear:(BOOL)animated {
    if ([[ValuesObject allValues] currentCombinedAverage] == -1.0) {
        self.percentAverageTextField.placeholder = @"%";
    } else {
        self.percentAverageTextField.text = [NSString stringWithFormat:@"%.2f", [[ValuesObject allValues] currentCombinedAverage]];
    }
    [self.goButton setEnabled:false];

}


- (IBAction)goPushed:(id)sender {
    
    //set the allValues variables to the onscreen values
    [[ValuesObject allValues] setCurrentCombinedAverage:[self.percentAverageTextField.text floatValue]];
    [[ValuesObject allValues] setFinalWeight:[self.finalWeight.text floatValue]];
    
    //move to next screen
    [self performSegueWithIdentifier:@"goSegue" sender:nil];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //resign the keyboard when background touched
    [self.percentAverageTextField resignFirstResponder];
    [self.finalWeight resignFirstResponder];
}

//- (void)keyboardWillShow {
//    //move the bottem label and textbox up if on an iPhone 4 screen
//    
//    if (!((int)[[UIScreen mainScreen] bounds].size.height == 568)) {
//        // This is iPhone 4/4s screen
//        
//        //get original values and store them for later use
//        self.originalLabel = self.weightWorthLabel.frame;
//        self.originalTextField = self.finalWeight.frame;
//        
//        CGRect labelFrame = self.weightWorthLabel.frame;
//        labelFrame.origin.y -= 40; // new y coordinate button
//        
//        //move the button up
//        CGRect textFieldFrame = self.finalWeight.frame;
//        textFieldFrame.origin.y -= 40;
//        
//        //execute animation of moving
//        [UIView animateWithDuration:0.3f animations:^ {
//            self.weightWorthLabel.frame = labelFrame;
//            self.finalWeight.frame = textFieldFrame;
//        }];
//    }
//}
//    
//- (void)keyboardWillHide {
//    [UIView animateWithDuration:0.3f animations:^ {
//        self.weightWorthLabel.frame = self.originalLabel;
//        self.finalWeight.frame = self.originalTextField;
//    }];
//}


















@end
