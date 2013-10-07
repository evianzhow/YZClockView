//
//  TimeIconView.m
//  TimeIcon
//
//  Created by Zhou Yifei on 13-10-7.
//  Copyright (c) 2013年 Zhou Yifei. All rights reserved.
//

#import "TimeIconView.h"

@implementation TimeIconView

@synthesize HH = _HH, MM = _MM;

- (void)drawInContext:(CGContextRef)context withHH:(int)hour andMM:(int)minute
{
    BOOL isAM = YES;
    if (hour < 0 || hour >= 24 || minute < 0 || minute >= 60) {
        return;
    }
    if (hour / 12 == 1) {
        isAM = NO;
    }
    CGFloat hourAngle = (hour % 12) / 12.0 * 2 * M_PI;
    CGFloat minuteAngle = minute / 60.0 * 2 * M_PI;
    
    //Radius
    CGFloat radius;
    if (self.bounds.size.height > self.bounds.size.width) {
        radius = self.bounds.size.width/2.0*0.9;
    } else {
        radius = self.bounds.size.height/2.0*0.9;
    }
    
    //Line Width
    CGContextSetLineWidth(context, radius*0.15);
    
    if (isAM == YES) {
        //HH Color. Different with A.M. and P.M.
        CGContextSetRGBStrokeColor(context, 18/255.0, 145/255.0, 169/255.0, 1.0);
    } else {
        CGContextSetRGBStrokeColor(context, 6/255.0, 95/255.0, 185/255.0, 1.0);
    }
    CGContextAddArc(context, self.bounds.size.width/2.0, self.bounds.size.height/2.0, radius, 3*M_PI/2.0, 3*M_PI/2.0+hourAngle, false);
    CGContextStrokePath(context);
    if (isAM == YES) {
        //MM Color. Different with A.M. and P.M.
        CGContextSetRGBStrokeColor(context, 114/255.0, 207/255.0, 215/255.0, 1.0);
    } else {
        CGContextSetRGBStrokeColor(context, 4/255.0, 159/255.0, 241/255.0, 1.0);
    }
    CGContextAddArc(context, self.bounds.size.width/2.0, self.bounds.size.height/2.0, radius * 0.8, 3*M_PI/2.0, 3*M_PI/2.0+minuteAngle, false);
    CGContextStrokePath(context);

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (!_HH && !_MM) {
        return;
    } else {
        [self drawInContext:UIGraphicsGetCurrentContext() withHH:self.HH andMM:self.MM];
    }
}


@end