//
//  UIColor+RandomColor.h
//  Twitterminal
//
//  Created by Julio César Guzmán on 1/4/14.
//  Copyright (c) 2014 Julio Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RandomColor)

+(UIColor *)randomColorWithOffset:(float)offset;
+(UIColor *)randomRedColorWithOffset:(float)offset;
+(UIColor *)randomGreenColorWithOffset:(float)offset;
+(UIColor *)randomBlueColorWithOffset:(float)offset;

@end
