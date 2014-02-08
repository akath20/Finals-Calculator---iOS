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
    self.zeroLabel.text = [NSString stringWithFormat:@"(%@) %.2f%%", [self gradeAsLetter:[[SharedValues allValues] lowestPossibleGrade]] ,[[SharedValues allValues] lowestPossibleGrade]];
    self.hundredLabel.text = [NSString stringWithFormat:@"(%@) %.2f%%",[self gradeAsLetter:[[SharedValues allValues] highestPossibleGrade]] ,[[SharedValues allValues] highestPossibleGrade]];
    
    
    
    //Check for keyboard show
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [self.hideKeyboardDoneButton setHidden:true];
    
   
    
    
    if ([[NSString stringWithString:[self gradeAsLetter:[[SharedValues allValues] highestPossibleGrade]]] isEqualToString:[self gradeAsLetter:[[SharedValues allValues] lowestPossibleGrade]]]) {
        //if the two strings are equal, then don't show or create the segment  (If more than one to show basically)
        NSLog(@"\nSame Letter");
    } else {
        //otherwise, format the segment
        //update the segment control to present the appropriate labels with passing the right things in
        [self formatSegmentControl:[NSString stringWithString:[self gradeAsLetter:[[SharedValues allValues] highestPossibleGrade]]] :[NSString stringWithString:[self gradeAsLetter:[[SharedValues allValues] lowestPossibleGrade]]]];
    }

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

- (void)formatSegmentControl:(NSString *)highLetterGrade :(NSString *)lowLetterGrade {
    //update the segment control to present the appropriate labels
    //CLEAN UP BY CUTTING OUT MIDDLE MAN
    NSString *highestScoreAsLetter = highLetterGrade;
    NSString *lowestScoreAsLetter = lowLetterGrade;
    NSLog(@"\nhighestScoreAsLetter: %@\nlowestScoreAsLetter: %@", highestScoreAsLetter, lowestScoreAsLetter);
    
    //set the index of the higest/lowest grade letter from the array
    int highGrade = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] indexOfObject:highestScoreAsLetter];
    int lowGrade = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] indexOfObject:lowestScoreAsLetter];
    
    //delete the older section down to two
    while ([self.getGradeSegment numberOfSegments] > 2) {
        [self.getGradeSegment removeSegmentAtIndex:[self.getGradeSegment numberOfSegments] animated:false];
    }
    
    //set first two to null
    [self.getGradeSegment setTitle:nil forSegmentAtIndex:0];
    [self.getGradeSegment setTitle:nil forSegmentAtIndex:1];
   
    int xCounter = 0;
    while (abs(highGrade-lowGrade) >= xCounter) {
        NSString *nestedTempTitle = [NSString stringWithString:[[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:(highGrade + xCounter)]];
        if (xCounter == 0) {
            [self.getGradeSegment setTitle:nestedTempTitle forSegmentAtIndex:0];
        } else if (xCounter == 1) {
            [self.getGradeSegment setTitle:nestedTempTitle forSegmentAtIndex:1];
        }
        else {
            [self.getGradeSegment insertSegmentWithTitle:nestedTempTitle atIndex:xCounter animated:false];
            
        }
        
        //increment the counter
        xCounter++;
    }
    
}

- (NSString *)gradeAsLetter:(float)passedGrade {
    
    //converts the percent to a letter grade
    
    NSMutableDictionary *gradeScale = [[SharedValues allValues] gradeScale];
    NSMutableString *returnString = [[NSMutableString alloc] initWithCapacity:2];
    if (passedGrade > [[gradeScale valueForKey:@"A"] floatValue]) {
        //return the letter here
        returnString = [@"A" mutableCopy];
    } else if (([[gradeScale valueForKey:@"A"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"A-"] floatValue])) {
        //return the letter here
        returnString = [@"A-" mutableCopy];
        //return @"A-";
    } else if (([[gradeScale valueForKey:@"A-"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"B+"] floatValue])) {
        //return the letter here
        returnString = [@"B+" mutableCopy];
        //return @"B+";
    } else if (([[gradeScale valueForKey:@"B+"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"B"] floatValue])) {
        //return the letter here
        returnString = [@"B" mutableCopy];
        //return @"B";
    } else if (([[gradeScale valueForKey:@"B"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"B-"] floatValue])) {
        //return the letter here
        returnString = [@"B-" mutableCopy];
        //return @"B-";
    } else if (([[gradeScale valueForKey:@"B-"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"C+"] floatValue])) {
        //return the letter here
        returnString = [@"C+" mutableCopy];
        //return @"C+";
    } else if (([[gradeScale valueForKey:@"C+"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"C"] floatValue])) {
        //return the letter here
        returnString = [@"C" mutableCopy];
        //return @"C";
    } else if (([[gradeScale valueForKey:@"C"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"C-"] floatValue])) {
        //return the letter here
        returnString = [@"C-" mutableCopy];
        //return @"C-";
    } else if (([[gradeScale valueForKey:@"C-"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"D+"] floatValue])) {
        //return the letter here
        returnString = [@"D+" mutableCopy];
        //return @"D+";
    } else if (([[gradeScale valueForKey:@"D+"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"D"] floatValue])) {
        //return the letter here
        returnString = [@"D" mutableCopy];
        //return @"D";
    } else if (([[gradeScale valueForKey:@"D"] floatValue] > passedGrade) && (passedGrade > [[gradeScale valueForKey:@"D-"] floatValue])) {
        //return the letter here
        returnString = [@"D-" mutableCopy];
        //return @"D-";
    } else if ([[gradeScale valueForKey:@"D-"] floatValue] > passedGrade) {
        //return the letter here
        returnString = [@"F" mutableCopy];
        //return @"F";
    }
    
    //Error; Shouldn't reach here, should return a value above
    //NSLog(@"Error. -> ResultsViewController.m -> -gradeAsLetter");
    return returnString;
}




















@end
