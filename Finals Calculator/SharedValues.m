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
    //That is if user got a zero on the final
    float termWeight = (1 - [[SharedValues allValues] finalWeight]);
    float lowestGrade = [[SharedValues allValues] currentCombinedAverage]*termWeight;
    
    return lowestGrade;
}

- (float)highestPossibleGrade {
    //ALL GOOD
    //this is if you get a 100 on the final
    //  *NOTE*    [[ShareValue allValues] variable] is the same thing as doing self.variable *NOTE*
    float highestGrade = ([[SharedValues allValues] currentCombinedAverage]*(1 - [[SharedValues allValues] finalWeight]))+(100*[[SharedValues allValues] finalWeight]);
    
    return highestGrade;
}



@end
