//
//  GetAverageViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 1/25/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "GetAverageViewController.h"
#import "FirstViewController.h"
#import "SharedValues.h"
@class FirstViewController;

@interface GetAverageViewController ()

@end

@implementation GetAverageViewController

#pragma mark Set Up
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //REEVALUTE TO SEE IF I SHOULD MOVE IT TO viewWillShow
    
    [self.buttonView setHidden:TRUE];
    self.whatsShowing = 0;
    
    //set observers to help with the keyboard show/hide methods
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //get original starting frame values for the moving objects on screen
    self.originalRectButtonView = self.buttonView.frame;
    self.originalRectMainView = self.view.frame;
//    self.originalRectCalculateButton = self.calculateButton.frame;
    self.originalInstructLabel = self.instructLabel.frame;
    [self.averageLabel setHidden:TRUE];
    haveValueToReturn = FALSE;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.backButtonOutlet setTitle:@"Back"];
}

- (void)viewDidDisappear:(BOOL)animated {
    //cancel the keyboardwatchers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark Keyboard

-(void)keyboardWillShow {
    
    
    //change the back button
    [self.backButtonOutlet setTitle:@"Done"];
    
    
    
    
    
    // Animate the current view out of the way
    
    /*
    origins:
    main frame: (0, 0, 320, 568)
    buttonView: (0, 155, 320, 413)
    act Button: (110, 217, 101, 30
     */
    
    //move the frames up
    if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
        // This is iPhone 5 screen
        
        //move button frame up
        CGRect buttonFrame = self.buttonView.frame;
        buttonFrame.origin.y -= 20; // new y coordinate button

        
        
//        //move the button up
//        CGRect calculateButtonFrame = self.calculateButton.frame;
//        calculateButtonFrame.origin.y -= 33;

        
        //execute animation of moving
        [UIView animateWithDuration:0.3f animations:^ {
            self.buttonView.frame = buttonFrame;
//            self.calculateButton.frame = calculateButtonFrame;
        }];
        
    } else {
        
        // This is iPhone 4/4s screen
    
        CGRect buttonFrame = self.buttonView.frame;
        buttonFrame.origin.y -= 105; // new y coordinate button

//        //move the button up
//        CGRect calculateButtonFrame = self.calculateButton.frame;
//        calculateButtonFrame.origin.y -= 35;

        //Move instruction label up
        CGRect instructRect = self.instructLabel.frame;
        instructRect.origin.y += 7;
        
        //execute animation of moving
        [UIView animateWithDuration:0.3f animations:^ {
            self.buttonView.frame = buttonFrame;
//            self.calculateButton.frame = calculateButtonFrame;
            self.termSeg.alpha = 0;
            self.howManyTermsLabel.alpha = 0;
            self.instructLabel.frame = instructRect;
        }];
        
    }
    
}

-(void)keyboardWillHide {
    
    //change the back button back
    [self.backButtonOutlet setTitle:@"Back"];
    
    
    
    // Animate the current view back to its original position
    [UIView animateWithDuration:0.3f animations:^ {
        self.buttonView.frame = self.originalRectButtonView;
        self.view.frame = self.originalRectMainView;
//        self.calculateButton.frame = self.originalRectCalculateButton;
        self.instructLabel.frame = self.originalInstructLabel;
        if (self.termSeg.alpha != 1) {
            self.termSeg.alpha = 1;
            self.howManyTermsLabel.alpha = 1;
        }
        
    }];
}

-(void)hideTheKeyboard {
    for (UITextField *currentField in self.textFieldsOutlet) {
        [currentField resignFirstResponder];
    }
}

#pragma mark Everything Else

- (IBAction)termsSegment:(id)sender {
    
    int x =-1;
    self.whatsShowing = 0;
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    for (UITextField *currentTextField in self.textFieldsOutlet) {
        if ([segControl selectedSegmentIndex] >= x ) {
            [currentTextField setHidden:FALSE];
            
            //DEBUG HERE
            [[self.percentLabels objectAtIndex:(x+1)] setHidden:FALSE];
            
            
            self.whatsShowing++;
        } else {
            [currentTextField setHidden:TRUE];
            [currentTextField setText:@""];
            [[self.percentLabels objectAtIndex:(x+1)] setHidden:true];

        }
        x++;
    }
    
    //if the visable text boxs are full, enable the calculate button
    if (self.visableTextsFull) {
        [self.calculateButton setEnabled:true];
    } else {
        [self.calculateButton setEnabled:FALSE];
    }
    
    [self.buttonView setHidden:FALSE];
    
}

- (IBAction)editingDidEnd:(UITextField *)sender {
    if (![sender.text isEqualToString:@""]) {
        if ([sender.text floatValue] > 110.0) {
            UIAlertView *tooHighAlert = [[UIAlertView alloc] initWithTitle:@"Value Too High" message:@"Value too high. Please insert a smaller value." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [tooHighAlert show];
            [sender becomeFirstResponder];
        } else if ([sender.text floatValue] <= 1.0) {
            UIAlertView *tooLowAlert = [[UIAlertView alloc] initWithTitle:@"Value Too Low" message:@"Value too low. Please insert a larger value." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [tooLowAlert show];
            [sender becomeFirstResponder];
        } else {
            //reformat the text
            [sender setText:[NSString stringWithFormat:@"%.2f", [sender.text floatValue]]];
            
            //if the visable text boxs are full, enable the calculate button
            if (self.visableTextsFull) {
                [self.calculateButton setEnabled:TRUE];
            } else {
                [self.calculateButton setEnabled:FALSE];
            }
            
        }
    }
    
    
   }

- (BOOL)visableTextsFull {
    //Check to see if the current showing text boxes are full
    BOOL tof = TRUE;
    xValue = 0;
    for (UITextField *currentTextField in self.textFieldsOutlet) {
        //if empty and it's showing, then return the texts aren't full
        if ([currentTextField.text isEqualToString:@""] && (xValue < self.whatsShowing)) {
            tof = FALSE;
            break;
        }
        xValue++;
    }
    return tof;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //if a touch happens on the screen then hide the keyboard
    [self hideTheKeyboard];
}

- (IBAction)calculateAverage:(id)sender {
    [self hideTheKeyboard];
    int y = 0;
    float averageSum = 0.0;
    for (UITextField *currentField in self.textFieldsOutlet) {
        if (self.whatsShowing >= y) {
            averageSum += [currentField.text floatValue];
        y++;
        } else {
            break;
        }
        
    }
    
    //Calculate Average and pass to the class
    actualAverage = (averageSum/((float)self.whatsShowing));

    //show the actual label and back button
    [self.averageLabel setText:[NSString stringWithFormat:@"Your Combined Average is: %.2f%%", actualAverage]];
    [self.averageLabel setHidden:FALSE];
    
    //enable the back button to return the value to the first screen textbox
    haveValueToReturn = true;
    
}

- (IBAction)backButton:(id)sender {
    if ([self.backButtonOutlet.title isEqualToString:@"Done"]) {
        [self hideTheKeyboard];
    } else {
        
        //if the keyboard isn't showing and it says it's the back button
        
        if (haveValueToReturn) {
            
            //set the allValues object equal to this
            [[SharedValues allValues] setCurrentCombinedAverage:actualAverage];
        }
        //might want to make currentcombined average to -1.0 here (see appDelegate)
        
        //set firstViewValue full 
        [[SharedValues allValues] setFirstViewFirstTextFull:true];
        
        
        
        //switch the views
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}






















@end
