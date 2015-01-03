//
//  UIColor+TimeIconView.m
//  TimeIcon
//
//  Created by Yifei Zhou on 12/30/14.
//  Copyright (c) 2014 Zhou Yifei. All rights reserved.
//

#import "UIColor+YZClockView.h"

@implementation UIColor (YZClockView)

+ (UIColor *)dayHourArcColor
{
    return [UIColor colorWithRed:18/255.0f green:145/255.0f blue:169/255.0f alpha:1.0f];
}

+ (UIColor *)dayMinuteArcColor
{
    return [UIColor colorWithRed:114/255.0f green:207/255.0f blue:215/255.0f alpha:1.0f];
}

+ (UIColor *)nightHourArcColor
{
    return [UIColor colorWithRed:6/255.0f green:95/255.0f blue:185/255.0f alpha:1.0f];
}

+ (UIColor *)nightMinuteArcColor
{
    return [UIColor colorWithRed:4/255.0f green:159/255.0f blue:241/255.0f alpha:1.0f];
}

+ (UIColor *)lightYellowColor
{
    return [UIColor colorWithRed:241/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
}
@end
