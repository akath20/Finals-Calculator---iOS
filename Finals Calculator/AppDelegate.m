//
//  AppDelegate.m
//  Finals Calculator
//
//  Created by Alex Atwater on 1/25/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//
#import "AppDelegate.h"
#import "SharedValues.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[SharedValues allValues] setCurrentCombinedAverage:-1.0];
    [[SharedValues allValues] setCurrentSelectedFirstViewSegmentIndex:-1];
    
    //for debugging purposes
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"defaultGradeScaleValues"];
    //NSLog(@"\nNSUserDefaults Cleaned");
    
    
    //iAd Shared Banner
    self.adBanner = [[ADBannerView alloc] init];
    
    if ((int)[[UIScreen mainScreen] bounds].size.height == 568) {
        //4 inch
        [self.adBanner setFrame:CGRectMake(0, 518, 320, 50)];
    } else {
        //3.5 inch
        [self.adBanner setFrame:CGRectMake(0, 430, 320, 50)];
        
    }
    
    
    
    [self.adBanner setDelegate:self];
    [self.adBanner setHidden:true];
    
    [[SharedValues allValues] setAdLoaded:false];
    
    
    
    //set the grade scale values if needed
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"]) {
        //if there isn't anything there (loaded for the first time) then create it
        
        //create the dictionary
        NSMutableDictionary *loadGradeDictionary = [[NSMutableDictionary alloc] initWithCapacity:11];
        
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
        
        [loadGradeDictionary setObject:[NSArray arrayWithObjects:@"A", @"A-", @"B+", @"B", @"B-", @"C+", @"C", @"C-", @"D+", @"D", @"D-", @"F" , nil] forKey:@"gradesArray"];
        
        //set it
        [[NSUserDefaults standardUserDefaults] setObject:loadGradeDictionary forKey:@"defaultGradeScaleValues"];
    
    }
    
    //then load into the SharedValues dictionary for global access throught the program
    [[SharedValues allValues] setGradeScale:[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"]];

    
    return YES;
}
							
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    NSLog(@"\nBanner Loaded");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bannerLoaded" object:self];
    [[SharedValues allValues] setAdLoaded:true];
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    NSLog(@"\nBanner failed to load");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bannerError" object:self];
    [[SharedValues allValues] setAdLoaded:false];
    
    
}


@end
