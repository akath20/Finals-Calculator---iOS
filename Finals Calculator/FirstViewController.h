
//
//  FirstViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 1/25/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *percentAverageTextField;
@property (strong, nonatomic) IBOutlet UITextField *finalWeight;
@property (strong, nonatomic) IBOutlet UIButton *goButton;
@property (strong, nonatomic) IBOutlet UILabel *weightWorthLabel;
@property (strong, nonatomic) IBOutlet UILabel *assumeNoLabel;
@property CGRect originalLabel;
@property CGRect originalTextField;

- (IBAction)goPushed:(id)sender;
- (IBAction)textboxEdited:(UITextField *)sender;
- (IBAction)segmentSelected:(UISegmentedControl *)sender;
- (IBAction)editingEndedTextbox:(id)sender;

@end

BOOL allFilledIn;
bool firstTextFull;
bool secondTextFull;
bool segmentSelected;
int xCount;
