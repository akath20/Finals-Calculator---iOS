//
//  ValuesObject.m
//  Finals Calculator
//
//  Created by Alex Atwater on 2/4/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "SharedValues.h"

@implementation SharedValues

+ (SharedValues *) allValues {

    static SharedValues *allValues;
    if (!allValues) {
        allValues = [[super allocWithZone:nil] init];
    }
    
    return allValues;
}

+ (id) allocWithZone:(struct _NSZone *)zone {
    return [self allValues];
}

#pragma mark Calculations

//- (void)highestPossibleGrade {
//    //Plus what you need to achieve that
//}

- (float)lowestPossibleGrade {
    //ALL GOOD
    
    
    float termWeight = (1 - [[SharedValues allValues] finalWeight]);
    float termPoints = [[SharedValues allValues] currentCombinedAverage]*termWeight;
    
    //That is if user got a zero on the final
    return termPoints;
}



@end
