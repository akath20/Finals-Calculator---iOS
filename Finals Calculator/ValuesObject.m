//
//  ValuesObject.m
//  Finals Calculator
//
//  Created by Alex Atwater on 2/4/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "ValuesObject.h"

@implementation ValuesObject

+ (ValuesObject *) allValues {

    static ValuesObject *allValues;
    if (!allValues) {
        allValues = [[super allocWithZone:nil] init];
    }
    
    return allValues;
}

+ (id) allocWithZone:(struct _NSZone *)zone {
    return [self allValues];
}



@end
