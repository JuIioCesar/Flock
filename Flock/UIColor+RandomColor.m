//
//  UIColor+RandomColor.m
//  Twitterminal
//
//  Created by Julio César Guzmán on 1/4/14.
//  Copyright (c) 2014 Julio Guzman. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+(UIColor *)randomColorWithOffset:(float)offset
{
    double r = ((double)arc4random() / 0x100000000);
    double g = ((double)arc4random() / 0x100000000);
    double b = ((double)arc4random() / 0x100000000);
    return [UIColor colorWithRed:r+offset green:g+offset blue:b+offset alpha:1.0];
}

+(UIColor *)randomRedColorWithOffset:(float)offset
{
    double r = ((double)arc4random() / 0x100000000);
    return [UIColor colorWithRed:r+offset green:1 blue:1 alpha:1.0];
}

+(UIColor *)randomGreenColorWithOffset:(float)offset
{
    double g = ((double)arc4random() / 0x100000000);
    return [UIColor colorWithRed:1 green:g+offset blue:1 alpha:1.0];
}

+(UIColor *)randomBlueColorWithOffset:(float)offset
{
    double b = ((double)arc4random() / 0x100000000);
    return [UIColor colorWithRed:1 green:1 blue:b+offset alpha:1.0];
}

@end
