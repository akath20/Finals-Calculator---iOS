//
//  AnalyzeViewController.h
//  Finals Calculator
//
//  Created by Alex Atwater on 2/4/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ResultsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UILabel *zeroLabel;
@property (strong, nonatomic) IBOutlet UILabel *hundredLabel;
@property (strong, nonatomic) IBOutlet UILabel *customScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *minScoreLabel;
@property (strong, nonatomic) IBOutlet UIView *scrollViewView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *getGradeSegment;
@property (strong, nonatomic) IBOutlet UITextField *customScoreTextFieldOutlet;
@property (strong, nonatomic) IBOutlet UIView *pickGradeView;
@property (strong, nonatomic) IBOutlet UIView *gradeAlreadyMadeView;
@property (strong, nonatomic) IBOutlet UILabel *gradeAlreadyMadeLabel;
@property (strong, nonatomic) IBOutlet UILabel *averageLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UIButton *viewGradeScaleButton;
@property (strong, nonatomic) IBOutlet UILabel *roundsUpLabel;
@property (strong, nonatomic) ADBannerView *adBanner;

- (IBAction)customScoreTextField:(id)sender;
- (IBAction)segmentValueChanged:(id)sender;
- (NSString *)gradeAsLetter:(float)x;

@end

bool showAlert;