//
//  FirstViewController.m
//  Finals Calculator
//
//  Created by Alex Atwater on 1/25/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "FirstViewController.h"
#import "SharedValues.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBanner) name:@"bannerLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerError) name:@"bannerError" object:nil];
    
    
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    
    self.adBanner = SharedAdBannerView;
    //[self.adBanner setFrame:CGRectMake(0, 50, 320, 50)];
    
    if ([[SharedValues allValues] adLoaded]) {
        [self loadBanner];
    } else {
        [self bannerError];
    }
    
    
    if (([[SharedValues allValues] currentCombinedAverage] == -1.0) || ([[SharedValues allValues] currentCombinedAverage] == 0.0)) {
        self.percentAverageTextField.placeholder = @"%";
    } else {
        self.percentAverageTextField.text = [NSString stringWithFormat:@"%.2f", [[SharedValues allValues] currentCombinedAverage]];
    }
    
    
    
    //set the selected segment index if loaded from another view
    if (([self.segmentOutlet selectedSegmentIndex] == -1) && ([[SharedValues allValues] currentSelectedFirstViewSegmentIndex] >= 0)) {
        //if nothing is selected and there is a previous load of it, then load it
        [self.segmentOutlet setSelectedSegmentIndex:[[SharedValues allValues] currentSelectedFirstViewSegmentIndex]];
    }

    
    
    //set the weight if loaded from another view and if previously set
    if (([self.finalWeight.text isEqualToString:@""]) && ([[SharedValues allValues] finalWeight])) {
        //if nothing is in the text box and there is something in the share class from before, load it
        [self.finalWeight setText:[NSString stringWithFormat:@"%.2f", ([[SharedValues allValues] finalWeight]*100)]];
    }
    
    if ([self allFilled]) {
        [self.goButton setEnabled:true];
    } else {
        [self.goButton setEnabled:false];
    }
    
    
    
    [self.view addSubview:self.adBanner];
    

}

- (IBAction)goPushed:(id)sender {
    
    //set the allValues variables to the onscreen values
    [[SharedValues allValues] setCurrentCombinedAverage:[self.percentAverageTextField.text floatValue]];
    
    //set weight
    //MAKE IT A DECIMAL
    [[SharedValues allValues] setFinalWeight:([self.finalWeight.text floatValue]/100)];
    
    //set round up
    if (self.segmentOutlet.selectedSegmentIndex == 0) {
        [[SharedValues allValues] setRoundUp:TRUE];
    } else {
        [[SharedValues allValues] setRoundUp:FALSE];
    }
    
    [[SharedValues allValues] setResultsAlreadyShown:false];
    
    //set the current segment segment
    [[SharedValues allValues] setCurrentSelectedFirstViewSegmentIndex:(int)[self.segmentOutlet selectedSegmentIndex]];
    
    //move to next screen
    [self performSegueWithIdentifier:@"goSegue" sender:self];
}

- (IBAction)textboxEdited:(UITextField *)sender {
    if (![sender.text isEqualToString:@""]) {
        //if something is in the textbox
        if (sender.tag == 0) {
            //if score text box
            if ([sender.text floatValue] > 110.0) {
                UIAlertView *tooHighAlert = [[UIAlertView alloc] initWithTitle:@"Value Too High" message:@"Value too high, please input a smaller average." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [tooHighAlert show];
                
                
                //go back to the textbox for new value
                [sender becomeFirstResponder];
            } else if ([sender.text floatValue] < 5.0) {
                UIAlertView *tooLowAlert = [[UIAlertView alloc] initWithTitle:@"Value Too Low" message:@"Value too low, please input a larger average." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [tooLowAlert show];
                
                
                //go back to the textbox for new value
                [sender becomeFirstResponder];
            } else {
                //if all good, say the text is full
                [sender setText:[NSString stringWithFormat:@"%.2f", [sender.text floatValue]]];
                
                //ERROR WOULD BE HERE
                [[SharedValues allValues] setCurrentCombinedAverage:[self.percentAverageTextField.text floatValue]];
            }
            
        } else {
            //if weight text box
            if ([sender.text floatValue] > 95.0) {
                UIAlertView *tooHighAlert = [[UIAlertView alloc] initWithTitle:@"Weight Too High" message:@"Weight too high, please input a smaller weight." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [tooHighAlert show];
                
                //go back to the textbox for new value
                [sender becomeFirstResponder];
            } else if ([sender.text floatValue] < 5.0) {
                UIAlertView *tooLowAlert = [[UIAlertView alloc] initWithTitle:@"Weight Too Low" message:@"Weight too low, please input a larger weight." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [tooLowAlert show];
                
                //go back to the textbox for new value
                [sender becomeFirstResponder];
            } else {
                //if all good, say the text is full
                [sender setText:[NSString stringWithFormat:@"%.2f", [sender.text floatValue]]];
                
                //ERROR WOULD BE HERE
                //set weight
                //MAKE IT A DECIMAL
                [[SharedValues allValues] setFinalWeight:([self.finalWeight.text floatValue]/100)];
                
            }
        }
        
        
    } else {
        if (sender.tag == 0) {
            //weight text box
            [[SharedValues allValues] setCurrentCombinedAverage:0.0];
            self.percentAverageTextField.placeholder = @"%";
        } else {
            //weight text box
            [[SharedValues allValues] setFinalWeight:0.0];
            self.finalWeight.placeholder = @"%";
        }

    }
    
    //check to see if enable button
    if ([self allFilled]) {
        [self.goButton setEnabled:true];
    } else {
        [self.goButton setEnabled:false];
    }
    
}

- (IBAction)segmentSelected:(UISegmentedControl *)sender {
    
    //-1 means nothing selected
    if (sender.selectedSegmentIndex >= 0) {
        if (sender.selectedSegmentIndex == 2) {
            [self.assumeNoLabel setHidden:false];
        } else {
            [self.assumeNoLabel setHidden:true];
        }
    } else {
        [self.assumeNoLabel setHidden:true];
    }
    
    //check to see if enable button
    if ([self allFilled]) {
        [self.goButton setEnabled:true];
    } else {
        [self.goButton setEnabled:false];
    }
    
    //set it in the shared class to later restore if necessary
    [[SharedValues allValues] setCurrentSelectedFirstViewSegmentIndex:(int)[self.segmentOutlet selectedSegmentIndex]];
}

- (BOOL)allFilled {

    if ([self.percentAverageTextField.text isEqualToString:@""] || [self.finalWeight.text isEqualToString:@""] || self.segmentOutlet.selectedSegmentIndex == -1) {
        return false;
    } else {
        return true;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //resign the keyboard when background touched
    [self.percentAverageTextField resignFirstResponder];
    [self.finalWeight resignFirstResponder];
}

- (IBAction)newsButton:(id)sender {
    
    UIAlertView *newsAlert = [[UIAlertView alloc] initWithTitle:@"News" message:@"Great News! Finals Calculator is now available on the web for all devices!  Want to try it out now?" delegate:self cancelButtonTitle:@"Not Right Now" otherButtonTitles:@"Yes!", nil];
    [newsAlert show];
}


#pragma mark Ads

- (void)loadBanner {
    [self.adBanner setHidden:false];
    
}

- (void)bannerError {
    [self.adBanner setHidden:true];
}

#pragma mark alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Yes!"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://alexatwater.com/webapps/finalscalculator"]];
    }
}





@end
