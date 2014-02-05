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
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //Get calculation and all the update all the labels when view is about to show
    self.zeroLabel.text = [NSString stringWithFormat:@"%.2f%%", [[SharedValues allValues] lowestPossibleGrade]];
    self.hundredLabel.text = [NSString stringWithFormat:@"%.2f%%", [[SharedValues allValues] highestPossibleGrade]];
    
    //reset the view in the scrollView
    [self.scrollViewView setFrame:CGRectMake(0, 0, 320, 800)];
    

}






- (IBAction)customScoreTextField:(id)sender {
    //put error checking here as well LATER
    
    
}
@end
