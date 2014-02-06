//
//  AnalyzeViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 2/4/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "ResultsViewController.h"
#import "SharedValues.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //make sure at runtime it doesn't account for the toolbar being there so that it's not moved down when accouting for it
    [self setAutomaticallyAdjustsScrollViewInsets:false];
    [self.mainScrollView setContentSize:CGSizeMake(320, 800)];
    
    //auto reposition so if i edit in IB it will return at runtime
    //y NOT 64 to not have a white space above it
    [self.scrollViewView setFrame:CGRectMake(0, 0, self.scrollViewView.frame.size.width, self.scrollViewView.frame.size.height)];

    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //Get calculation and all the update all the labels when view is about to show
    self.zeroLabel.text = [NSString stringWithFormat:@"%.2f%%", [[SharedValues allValues] lowestPossibleGrade]];
    self.hundredLabel.text = [NSString stringWithFormat:@"%.2f%%", [[SharedValues allValues] highestPossibleGrade]];
    
    
    
    //Check for keyboard show
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [self.hideKeyboardDoneButton setHidden:true];
    

}

//cancel the keyboard watchers
- (void)viewDidDisappear:(BOOL)animated {
    //cancel the keyboardwatchers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


-(void)keyboardWillShow {
    //move the view up AND create a show the done button to hide the keyboard
    [self.hideKeyboardDoneButton setHidden:false];
    
}


- (IBAction)customScoreTextField:(id)sender {
    //put error checking here as well LATER
    if (![self.customScoreTextFieldOutlet.text isEqualToString:@""]) {
        float customValue = [[(UITextField *)sender text] floatValue];
        
        //run the calculation and update the label
        self.customScoreLabel.text = [NSString stringWithFormat:@"%.2f%%", [[SharedValues allValues] customScore:customValue]];
        
        //reformat the textbox
        //[sender setText:[NSString stringWithFormat:@"%.2f", [sender.text floatValue]]];
        [self.customScoreTextFieldOutlet setText:[NSString stringWithFormat:@"%.2f", [self.customScoreTextFieldOutlet.text floatValue]]];
    } else {
        //and reset the placeholder the textbox
        self.customScoreTextFieldOutlet.text = @"";
        self.customScoreTextFieldOutlet.placeholder = @"%";
    }
    
    
}

- (IBAction)segmentValueChanged:(id)sender {
}

- (IBAction)hideKeyboardButton:(id)sender {
    
    //error check textfield here TO DO OR BELOW
    [self.customScoreTextFieldOutlet resignFirstResponder];
    [self.hideKeyboardDoneButton setHidden:true];
}
























@end
