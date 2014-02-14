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
    float termWeight = (1 - [[NSString stringWithFormat:@"%.2f", [[SharedValues allValues] finalWeight]] floatValue]);
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

- (float)customScore:(float)customScore {
    float customGrade = ([[SharedValues allValues] currentCombinedAverage]*(1 - [[SharedValues allValues] finalWeight]))+(customScore*[[SharedValues allValues] finalWeight]);
    
    return customGrade;
}

- (void)createDictionary {
    
    
    if (![[SharedValues allValues] roundUp]) {
        
        //decide how to create the dictionary
        NSMutableDictionary *loadGradeDictionary = [[NSMutableDictionary alloc] initWithCapacity:11];
        //also set a NSArray to be able to loop through the grades reliably
        [loadGradeDictionary setObject:[NSArray arrayWithObjects:@"A", @"A-", @"B+", @"B", @"B-", @"C+", @"C", @"C-", @"D+", @"D", @"D-", @"F" , nil] forKey:@"gradesArray"];
        
        //if teacher doesn't round up, temp add .5 to the default values that were loaded
        
        //if the teacher doesn't round up, add +.5 to make sure that that min value is at least this if not round up
        //Set up the dictionary of the grade scale
        //create
        
        
        //load values OVERRIDE USER GIVEN VALUES HERE
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"A"] floatValue] + 0.5)] forKey:@"A"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"A-"] floatValue] + 0.5)] forKey:@"A-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B+"] floatValue] + 0.5)] forKey:@"B+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B"] floatValue] + 0.5)] forKey:@"B"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B-"] floatValue] + 0.5)] forKey:@"B-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C+"] floatValue] + 0.5)] forKey:@"C+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C"] floatValue] + 0.5)] forKey:@"C"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C-"] floatValue] + 0.5)] forKey:@"C-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D+"] floatValue] + 0.5)] forKey:@"D+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D"] floatValue] + 0.5)] forKey:@"D"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D-"] floatValue] + 0.5)] forKey:@"D-"];
        
        //set the dictionary in sharedValues
        [[SharedValues allValues] setGradeScale:loadGradeDictionary];
    }
    
}

- (void)resetDictionary {
    
    //minus .5 if you had to when the view was shown
    if (![[SharedValues allValues] roundUp]) {
        NSMutableDictionary *loadGradeDictionary = [[NSMutableDictionary alloc] initWithCapacity:11];
        //if teacher doesn't round up, temp add .5 to the default values that were loaded
        
        //if the teacher doesn't round up, add +.5 to make sure that that min value is at least this if not round up
        //Set up the dictionary of the grade scale
        //create
        //also set a NSArray to be able to loop through the grades reliably
        [loadGradeDictionary setObject:[NSArray arrayWithObjects:@"A", @"A-", @"B+", @"B", @"B-", @"C+", @"C", @"C-", @"D+", @"D", @"D-", @"F" , nil] forKey:@"gradesArray"];
        
        
        //load values OVERRIDE USER GIVEN VALUES HERE
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"A"] floatValue] - 0.5)] forKey:@"A"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"A-"] floatValue] - 0.5)] forKey:@"A-"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B+"] floatValue] - 0.5)] forKey:@"B+"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B"] floatValue] - 0.5)] forKey:@"B"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B-"] floatValue] - 0.5)] forKey:@"B-"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C+"] floatValue] - 0.5)] forKey:@"C+"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C"] floatValue] - 0.5)] forKey:@"C"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C-"] floatValue] - 0.5)] forKey:@"C-"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D+"] floatValue] - 0.5)] forKey:@"D+"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D"] floatValue] - 0.5)] forKey:@"D"];
        //        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D-"] floatValue] - 0.5)] forKey:@"D-"];

        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"A"] floatValue])] forKey:@"A"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"A-"] floatValue])] forKey:@"A-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B+"] floatValue])] forKey:@"B+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B"] floatValue])] forKey:@"B"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"B-"] floatValue])] forKey:@"B-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C+"] floatValue])] forKey:@"C+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C"] floatValue])] forKey:@"C"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"C-"] floatValue])] forKey:@"C-"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D+"] floatValue])] forKey:@"D+"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D"] floatValue])] forKey:@"D"];
        [loadGradeDictionary setObject:[NSString stringWithFormat:@"%.2f",  ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultGradeScaleValues"] objectForKey:@"D-"] floatValue])] forKey:@"D-"];
        
        
        
        //set the dictionary in sharedValues
        [[SharedValues allValues] setGradeScale:loadGradeDictionary];
    }
    
}

@end
