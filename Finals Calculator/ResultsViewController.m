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
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.zeroLabel.text = [NSString stringWithFormat:@"%.2f", [[SharedValues allValues] lowestPossibleGrade]];
}






@end
