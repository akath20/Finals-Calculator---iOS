//
//  AnalyzeViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 2/4/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "ResultsViewController.h"
#import "SharedValues.h"

@interface ResultsViewController () {
    UITapGestureRecognizer *yourTap;
}

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
    
    //init the gesture tap
    yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap)];

}

- (void)viewWillAppear:(BOOL)animated {
    //create the grade scale dictionary
    [self createDictionary];
    
    //Get calculation and all the update all the labels when view is about to show
    self.zeroLabel.text = [NSString stringWithFormat:@"(%@) %.2f%%", [self gradeAsLetter:[[SharedValues allValues] lowestPossibleGrade]] ,[[SharedValues allValues] lowestPossibleGrade]];
    self.hundredLabel.text = [NSString stringWithFormat:@"(%@) %.2f%%",[self gradeAsLetter:[[SharedValues allValues] highestPossibleGrade]] ,[[SharedValues allValues] highestPossibleGrade]];
    
    NSLog(@"\nzeroLabel: %@\nhundredLabel: %@", self.zeroLabel.text, self.hundredLabel.text);
    
    
    //Check for keyboard show/hide
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    if ([[NSString stringWithString:[self gradeAsLetter:[[SharedValues allValues] highestPossibleGrade]]] isEqualToString:[self gradeAsLetter:[[SharedValues allValues] lowestPossibleGrade]]]) {
        //if the two strings are equal, then don't show or create the segment  (If more than one to show basically)
        //hide the view and move the view behind up
        //MOVE THE VIEW UP
        [self.pickGradeView setHidden:true];
        
    } else {
        //otherwise, format the segment and show the view
        //update the segment control to present the appropriate labels with passing the right things in
        NSLog(@"\nlowestPossibleGrade: %f", [[SharedValues allValues] lowestPossibleGrade]);
        NSLog(@"\nlowLetterGrade Sent As: %@", [NSString stringWithFormat:@"%@", [self gradeAsLetter:[[SharedValues allValues] lowestPossibleGrade]]]);
        [self formatSegmentControl:[NSString stringWithString:[self gradeAsLetter:[[SharedValues allValues] highestPossibleGrade]]] :[NSString stringWithString:[self gradeAsLetter:[[SharedValues allValues] lowestPossibleGrade]]]];
        
        //show the view
        [self.pickGradeView setHidden:false];
    }

}

- (void)keyboardWillHide {
    [self.mainScrollView removeGestureRecognizer:yourTap];
}

- (void)viewDidDisappear:(BOOL)animated {
    //cancel the keyboardwatchers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

-(void)keyboardWillShow {
    //detect the tap when keyboard is up
       [self.mainScrollView addGestureRecognizer:yourTap];
    
}

- (void)scrollTap {
    [self.customScoreTextFieldOutlet resignFirstResponder];
}

- (IBAction)customScoreTextField:(id)sender {
    //error check and update the label
    if (![self.customScoreTextFieldOutlet.text isEqualToString:@""]) {
        //if there is a value here
        
        float customValue = [[(UITextField *)sender text] floatValue];
        
        //if score text box
        if (customValue > 100.0) {
            UIAlertView *tooHighAlert = [[UIAlertView alloc] initWithTitle:@"Score Too High" message:@"Value cannot exceed 100%, please input a smaller score." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [tooHighAlert show];
            
            //go back to the textbox for new value
            [sender becomeFirstResponder];
        } else if (customValue < 20.0) {
            UIAlertView *tooLowAlert = [[UIAlertView alloc] initWithTitle:@"Score Too Low" message:@"Value too low, please input a larger score." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [tooLowAlert show];
            
            //go back to the textbox for new value
            [sender becomeFirstResponder];
        } else {
            //If everything is all good
            //run the calculation and update the label
            self.customScoreLabel.text = [NSString stringWithFormat:@"%.2f%%", [[SharedValues allValues] customScore:customValue]];
            
            //reformat the textbox
            //[sender setText:[NSString stringWithFormat:@"%.2f", [sender.text floatValue]]];
            [self.customScoreTextFieldOutlet setText:[NSString stringWithFormat:@"%.2f", [self.customScoreTextFieldOutlet.text floatValue]]];
            
        }
        
    } else {
        //if no value in textbox
        //and reset the placeholder the textbox
        self.customScoreTextFieldOutlet.text = @"";
        self.customScoreTextFieldOutlet.placeholder = @"%";
    }
    
    
}

- (IBAction)segmentValueChanged:(id)sender {
    
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

    NSDictionary *gradeScale = [[SharedValues allValues] gradeScale];
    NSMutableString *returnString = [[NSMutableString alloc] initWithCapacity:2];
    NSString *xString = [NSString stringWithFormat:@"%.2f", passedGrade];
    
    if (([xString floatValue] > [[gradeScale valueForKey:@"A"] floatValue])) {
        //return the letter here
        returnString = [@"A" mutableCopy];
    } else if (([[gradeScale valueForKey:@"A"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"A-"] floatValue])) {
        //return the letter here
        returnString = [@"A-" mutableCopy];
        //return @"A-";
    } else if (([[gradeScale valueForKey:@"A-"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"B+"] floatValue])) {
        //return the letter here
        returnString = [@"B+" mutableCopy];
        //return @"B+";
    } else if (([[gradeScale valueForKey:@"B+"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"B"] floatValue])) {
        //return the letter here
        returnString = [@"B" mutableCopy];
        //return @"B";
    } else if (([[gradeScale valueForKey:@"B"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"B-"] floatValue])) {
        //return the letter here
        returnString = [@"B-" mutableCopy];
        //return @"B-";
    } else if (([[gradeScale valueForKey:@"B-"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"C+"] floatValue])) {
        //return the letter here
        returnString = [@"C+" mutableCopy];
        //return @"C+";
    } else if (([[gradeScale valueForKey:@"C+"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"C"] floatValue])) {
        //return the letter here
        returnString = [@"C" mutableCopy];
        //return @"C";
    } else if (([[gradeScale valueForKey:@"C"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"C-"] floatValue])) {
        //return the letter here
        returnString = [@"C-" mutableCopy];
        //return @"C-";
    } else if (([[gradeScale valueForKey:@"C-"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"D+"] floatValue])) {
        //return the letter here
        returnString = [@"D+" mutableCopy];
        //return @"D+";
    } else if (([[gradeScale valueForKey:@"D+"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"D"] floatValue])) {
        //return the letter here
        returnString = [@"D" mutableCopy];
        //return @"D";
    } else if (([[gradeScale valueForKey:@"D"] floatValue] > passedGrade) && (passedGrade >= [[gradeScale valueForKey:@"D-"] floatValue])) {
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


- (void)createDictionary {
    //decide how to create the dictionary
    NSMutableDictionary *loadGradeDictionary = [[NSMutableDictionary alloc] initWithCapacity:11];
    //also set a NSArray to be able to loop through the grades reliably
    [loadGradeDictionary setObject:[NSArray arrayWithObjects:@"A", @"A-", @"B+", @"B", @"B-", @"C+", @"C", @"C-", @"D+", @"D", @"D-", @"F" , nil] forKey:@"gradesArray"];
    
    if ([[SharedValues allValues] roundUp]) {
        //if the teacher rounds up leave it the way it is with .5 values
        //Set up the dictionary of the grade scale
        //create
        
        
        //load values OVERRIDE USER GIVEN VALUES HERE

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
        
        
        
        //set the dictionary in sharedValues
                
    } else {
        
        //if the teacher doesn't round up, add +.5 to make sure that that min value is at least this if not round up
        //Set up the dictionary of the grade scale
        //create
        
        
        //load values OVERRIDE USER GIVEN VALUES HERE
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (92.5 + 0.5)] forKey:@"A"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (89.5 + 0.5)] forKey:@"A-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (86.5 + 0.5)] forKey:@"B+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (82.5 + 0.5)] forKey:@"B"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (79.5 + 0.5)] forKey:@"B-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (76.5 + 0.5)] forKey:@"C+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (72.5 + 0.5)] forKey:@"C"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (69.5 + 0.5)] forKey:@"C-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (66.5 + 0.5)] forKey:@"D+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (62.5 + 0.5)] forKey:@"D"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  (59.5 + 0.5)] forKey:@"D-"];
        
        
        
        
        
        //set the dictionary in sharedValues
        
    }
    [[SharedValues allValues] setGradeScale:loadGradeDictionary];
}














@end
