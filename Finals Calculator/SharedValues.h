//
//  ValuesObject.h
//  Finals Calculator
//
//  Created by Alex Atwater on 2/4/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedValues : NSObject

@property float currentCombinedAverage;
@property float finalWeight;
@property NSMutableDictionary *gradeScale;
@property bool roundUp;
@property bool firstViewFirstTextFull;
@property BOOL resultsAlreadyShown;
@property BOOL comingFromResultsView;
@property int currentSelectedFirstViewSegmentIndex;
@property BOOL adLoaded;

+ (SharedValues *) allValues;

- (float)lowestPossibleGrade;
- (float)highestPossibleGrade;
- (float)customScore:(float)customScore;
- (void)createDictionary;
- (void)resetDictionary;
@end
