//
//  AnalyzeViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 2/4/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "AnalyzeViewController.h"
#import "ValuesObject.h"

@interface AnalyzeViewController ()

@end

@implementation AnalyzeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark Calculations
- (void)highestPossibleGrade {
    //Plus what you need to achieve that
}

-(float)lowestPossibleGrade {
    float termWeight = (100 - [[ValuesObject allValues] finalWeight]);
    float termPoints = [[ValuesObject allValues] currentCombinedAverage]*termWeight;
    
    //That is if user got a zero on the final
    return termPoints;
    
    
}



@end
