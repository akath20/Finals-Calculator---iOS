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
@property BOOL roundUp;
@property NSMutableDictionary *gradeScale;

+ (SharedValues *) allValues;

- (float)lowestPossibleGrade;
- (float)highestPossibleGrade;
- (float)customScore:(float)customScore;
@end
