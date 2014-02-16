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

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //hide the assume no label
    [self.assumeNoLabel setHidden:true];
    
    
}

- (void) viewWillAppear:(BOOL)animated {
        
    //set the firstTextBoxFull property from the shared class
    self.firstTextFull = [[SharedValues allValues] firstViewFirstTextFull];
    
    
    if (([[SharedValues allValues] currentCombinedAverage] == -1.0) || ([[SharedValues allValues] currentCombinedAverage] == 0.0)) {
        self.percentAverageTextField.placeholder = @"%";
    } else {
        self.percentAverageTextField.text = [NSString stringWithFormat:@"%.2f", [[SharedValues allValues] currentCombinedAverage]];
    }
    if ([self allFilled]) {
        [self.goButton setEnabled:true];
    } else {
        [self.goButton setEnabled:false];
    }
    
    //set the selected segment index if loaded from another view
    if (([self.segmentOutlet selectedSegmentIndex] == -1) && ([[SharedValues allValues] currentSelectedFirstViewSegmentIndex] >= 0)) {
        //if nothing is selected and there is a previous load of it, then load it
        [self.segmentOutlet setSelectedSegmentIndex:[[SharedValues allValues] currentSelectedFirstViewSegmentIndex]];
    }

    
    
    //set the weight if loaded from another view and if previously set
    if (([self.finalWeight.text isEqualToString:@""]) && ([[SharedValues allValues] finalWeight])) {
        //if nothing is in the text box and there is something in the share class from before, load it
        [self.finalWeight setText:[NSString stringWithFormat:@"%.2f", ([[SharedValues allValues] finalWeight]*100)]];
    }
    

    
}

- (IBAction)goPushed:(id)sender {
    
    //set the allValues variables to the onscreen values
    [[SharedValues allValues] setCurrentCombinedAverage:[self.percentAverageTextField.text floatValue]];
    
    //set weight
    //MAKE IT A DECIMAL
    [[SharedValues allValues] setFinalWeight:([self.finalWeight.text floatValue]/100)];
    
    //set round up
    if (self.segmentOutlet.selectedSegmentIndex == 0) {
        [[SharedValues allValues] setRoundUp:TRUE];
    } else {
        [[SharedValues allValues] setRoundUp:FALSE];
    }
    
    [[SharedValues allValues] setResultsAlreadyShown:false];
    
    //set the current segment segment
    [[SharedValues allValues] setCurrentSelectedFirstViewSegmentIndex:(int)[self.segmentOutlet selectedSegmentIndex]];
    
    //move to next screen
    [self performSegueWithIdentifier:@"goSegue" sender:self];
}

- (IBAction)textboxEdited:(UITextField *)sender {
    if (![sender.text isEqualToString:@""]) {
        //if something is in the textbox
        if (sender.tag == 0) {
            //if score text box
            if ([sender.text floatValue] > 110.0) {
                UIAlertView *tooHighAlert = [[UIAlertView alloc] initWithTitle:@"Value Too High" message:@"Value too high, please input a smaller average." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [tooHighAlert show];
                self.firstTextFull = false;
                
                //go back to the textbox for new value
                [sender becomeFirstResponder];
            } else if ([sender.text floatValue] < 5.0) {
                UIAlertView *tooLowAlert = [[UIAlertView alloc] initWithTitle:@"Value Too Low" message:@"Value too low, please input a larger average." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [tooLowAlert show];
                self.firstTextFull = false;
                
                //go back to the textbox for new value
                [sender becomeFirstResponder];
            } else {
                //if all good, say the text is full
                self.firstTextFull = true;
                [sender setText:[NSString stringWithFormat:@"%.2f", [sender.text floatValue]]];
                
                //ERROR WOULD BE HERE
                [[SharedValues allValues] setCurrentCombinedAverage:[self.percentAverageTextField.text floatValue]];
            }
            
        } else {
            //if weight text box
            if ([sender.text floatValue] > 95.0) {
                UIAlertView *tooHighAlert = [[UIAlertView alloc] initWithTitle:@"Weight Too High" message:@"Weight too high, please input a smaller weight." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [tooHighAlert show];
                secondTextFull = false;
                
                //go back to the textbox for new value
                [sender becomeFirstResponder];
            } else if ([sender.text floatValue] < 5.0) {
                UIAlertView *tooLowAlert = [[UIAlertView alloc] initWithTitle:@"Weight Too Low" message:@"Weight too low, please input a larger weight." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [tooLowAlert show];
                secondTextFull = false;
                
                //go back to the textbox for new value
                [sender becomeFirstResponder];
            } else {
                //if all good, say the text is full
                secondTextFull = true;
                [sender setText:[NSString stringWithFormat:@"%.2f", [sender.text floatValue]]];
                
                //ERROR WOULD BE HERE
                //set weight
                //MAKE IT A DECIMAL
                [[SharedValues allValues] setFinalWeight:([self.finalWeight.text floatValue]/100)];
                
            }
        }
        
        
    } else {
        if (sender.tag == 0) {
            //weight text box
            self.firstTextFull = false;
            [[SharedValues allValues] setCurrentCombinedAverage:0.0];
            self.percentAverageTextField.placeholder = @"%";
        } else {
            //weight text box
            [[SharedValues allValues] setFinalWeight:0.0];
            self.finalWeight.placeholder = @"%";
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
        if (sender.selectedSegmentIndex == 2) {
            [self.assumeNoLabel setHidden:false];
        } else {
            [self.assumeNoLabel setHidden:true];
        }
    } else {
        segmentSelected = false;
        [self.assumeNoLabel setHidden:true];
    }
    
    //check to see if enable button
    if ([self allFilled]) {
        [self.goButton setEnabled:true];
    } else {
        [self.goButton setEnabled:false];
    }
    
    //set it in the shared class to later restore if necessary
    [[SharedValues allValues] setCurrentSelectedFirstViewSegmentIndex:(int)[self.segmentOutlet selectedSegmentIndex]];
}

- (BOOL)allFilled {
    xCount = 0;
    
    if (self.firstTextFull) {
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
