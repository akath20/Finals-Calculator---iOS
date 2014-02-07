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
    
    //update the segment control to present the appropriate labels
    [self formatSegmentControl];
    

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

- (void)formatSegmentControl {
    //update the segment control to present the appropriate labels
    float lowestScore = [[SharedValues allValues] lowestPossibleGrade];
    float highestScore = [[SharedValues allValues] highestPossibleGrade];
    NSString *highestScoreAsLetter = [[NSString alloc] initWithString:[self gradeAsLetter:highestScore]];
    NSString *lowestScoreAsLetter = [[NSString alloc] initWithString:[self gradeAsLetter:lowestScore]];
    NSLog(@"\nhighestScoreAsLetter: %@\nlowestScoreAsLetter: %@", highestScoreAsLetter, lowestScoreAsLetter);
    //ALL SET HERE AND BELOW
    
    //set the index of the higest/lowest grade letter from the array
    int highGrade = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] indexOfObject:highestScoreAsLetter];
    int lowGrade = [[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] indexOfObject:lowestScoreAsLetter];
    
    //delete the older section down to two
    while ([self.getGradeSegment numberOfSegments] > 2) {
        [self.getGradeSegment removeSegmentAtIndex:[self.getGradeSegment numberOfSegments] animated:false];
    }
    
    //add the new ones in (modify first two, then add the rest
    [self.getGradeSegment setTitle:highestScoreAsLetter forSegmentAtIndex:0];
    
    //if there is an error it would be *HERE*
    NSString *tempTitle = [NSString stringWithString:[[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:(highGrade + 1)]];
    [self.getGradeSegment setTitle:tempTitle forSegmentAtIndex:1];
   
    //add the rest of the segments here
    // ALSO HERE
    for (int i = 2; lowGrade > i; i++) {
        NSString *nestedTempTitle = [NSString stringWithString:[[[[SharedValues allValues] gradeScale] objectForKey:@"gradesArray"] objectAtIndex:(highGrade + i)]];
        NSLog(@"\n%d: %@", i, nestedTempTitle);
        [self.getGradeSegment insertSegmentWithTitle:nestedTempTitle atIndex:i animated:false];
    }
    
}

- (NSString *)gradeAsLetter:(float)x {
    
    //converts the percent to a letter grade
    
    NSMutableDictionary *gradeScale = [[SharedValues allValues] gradeScale];
    NSMutableString *returnString = [[NSMutableString alloc] initWithCapacity:2];
    if (x > [[gradeScale valueForKey:@"A"] floatValue]) {
        //return the letter here
        returnString = [@"A" mutableCopy];
    } else if (([[gradeScale valueForKey:@"A"] floatValue] > x) && (x > [[gradeScale valueForKey:@"A-"] floatValue])) {
        //return the letter here
        returnString = [@"A-" mutableCopy];
        //return @"A-";
    } else if (([[gradeScale valueForKey:@"A-"] floatValue] > x) && (x > [[gradeScale valueForKey:@"B+"] floatValue])) {
        //return the letter here
        returnString = [@"B+" mutableCopy];
        //return @"B+";
    } else if (([[gradeScale valueForKey:@"B+"] floatValue] > x) && (x > [[gradeScale valueForKey:@"B"] floatValue])) {
        //return the letter here
        returnString = [@"B" mutableCopy];
        //return @"B";
    } else if (([[gradeScale valueForKey:@"B"] floatValue] > x) && (x > [[gradeScale valueForKey:@"B-"] floatValue])) {
        //return the letter here
        returnString = [@"B-" mutableCopy];
        //return @"B-";
    } else if (([[gradeScale valueForKey:@"B-"] floatValue] > x) && (x > [[gradeScale valueForKey:@"C+"] floatValue])) {
        //return the letter here
        returnString = [@"C+" mutableCopy];
        //return @"C+";
    } else if (([[gradeScale valueForKey:@"C+"] floatValue] > x) && (x > [[gradeScale valueForKey:@"C"] floatValue])) {
        //return the letter here
        returnString = [@"C" mutableCopy];
        //return @"C";
    } else if (([[gradeScale valueForKey:@"C"] floatValue] > x) && (x > [[gradeScale valueForKey:@"C-"] floatValue])) {
        //return the letter here
        returnString = [@"C-" mutableCopy];
        //return @"C-";
    } else if (([[gradeScale valueForKey:@"C-"] floatValue] > x) && (x > [[gradeScale valueForKey:@"D+"] floatValue])) {
        //return the letter here
        returnString = [@"D+" mutableCopy];
        //return @"D+";
    } else if (([[gradeScale valueForKey:@"D+"] floatValue] > x) && (x > [[gradeScale valueForKey:@"D"] floatValue])) {
        //return the letter here
        returnString = [@"D" mutableCopy];
        //return @"D";
    } else if (([[gradeScale valueForKey:@"D"] floatValue] > x) && (x > [[gradeScale valueForKey:@"D-"] floatValue])) {
        //return the letter here
        returnString = [@"D-" mutableCopy];
        //return @"D-";
    } else if ([[gradeScale valueForKey:@"D-"] floatValue] > x) {
        //return the letter here
        returnString = [@"F" mutableCopy];
        //return @"F";
    }
    
    //Error; Shouldn't reach here, should return a value above
    //NSLog(@"Error. -> ResultsViewController.m -> -gradeAsLetter");
    return returnString;
}




















@end
