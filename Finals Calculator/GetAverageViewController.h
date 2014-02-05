//
//  GetAverageViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 1/25/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetAverageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldsOutlet;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *termSeg;
@property (weak, nonatomic) IBOutlet UILabel *howManyTermsLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;


//this might belong as a class instance variable rather than a property; doesn't really matter, but cleaner code
@property int whatsShowing;
@property CGRect originalRectButtonView;
@property CGRect originalRectMainView;
@property CGRect originalRectCalculateButton;
@property CGRect originalInstructLabel;

- (IBAction)calculateAverage:(id)sender;
- (IBAction)backButton:(id)sender;
@end

int xValue;
float actualAverage;
BOOL haveValueToReturn;

