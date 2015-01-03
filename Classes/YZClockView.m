//
//  TimeIconView.m
//  TimeIcon
//
//  Created by Zhou Yifei on 13-10-7.
//  Copyright (c) 2013年 Zhou Yifei. All rights reserved.
//

#import "YZClockView.h"

@interface YZClockView ()

@property (nonatomic) CAShapeLayer *hourArc;
@property (nonatomic) CAShapeLayer *minuteArc;

@end

@implementation YZClockView

- (instancetype)initWithFrame:(CGRect)frame HH:(NSNumber *)hour MM:(NSNumber *)minute shadow:(BOOL)hasBackgroundShadow
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _HH = hour;
        _MM = minute;
        _duration = 1.0f;
        
        CGFloat startAngle = -90.00f;
        CGFloat endAngle = -90.01f;
        
        CGFloat radius = self.bounds.size.height > self.bounds.size.width ? self.bounds.size.width/2.0*0.9f : self.bounds.size.height/2.0*0.9f;
        _lineWidth = @(radius * 0.15f);
        
        UIBezierPath *hourPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0)
                                                                radius:radius
                                                            startAngle:DEGREES_TO_RADIANS(startAngle)
                                                              endAngle:DEGREES_TO_RADIANS(endAngle)
                                                             clockwise:YES];
        _hourArc               = [CAShapeLayer layer];
        _hourArc.path          = hourPath.CGPath;
        _hourArc.lineCap       = kCALineCapSquare;
        _hourArc.fillColor     = [UIColor clearColor].CGColor;
        _hourArc.lineWidth     = [_lineWidth floatValue];
        _hourArc.zPosition     = 1;
        
        UIBezierPath *minutePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0)
                                                                  radius:radius*0.8f
                                                              startAngle:DEGREES_TO_RADIANS(startAngle)
                                                                endAngle:DEGREES_TO_RADIANS(endAngle)
                                                               clockwise:YES];
        _minuteArc               = [CAShapeLayer layer];
        _minuteArc.path          = minutePath.CGPath;
        _minuteArc.lineCap       = kCALineCapSquare;
        _minuteArc.fillColor     = [UIColor clearColor].CGColor;
        _minuteArc.lineWidth     = [_lineWidth floatValue];
        _minuteArc.zPosition     = 1;
        
        // Hour Arc Background
        CAShapeLayer *hourArcBg = [CAShapeLayer layer];
        hourArcBg.path          = hourPath.CGPath;
        hourArcBg.fillColor     = [UIColor clearColor].CGColor;
        hourArcBg.lineCap       = kCALineCapSquare;
        hourArcBg.strokeColor   = (hasBackgroundShadow ? [UIColor lightYellowColor].CGColor : [UIColor clearColor].CGColor);
        hourArcBg.strokeEnd     = 1.0f;
        hourArcBg.lineWidth     = [_lineWidth floatValue];
        hourArcBg.zPosition     = -1;
        
        // Minute Arc Background
        CAShapeLayer *minuteArcBg = [CAShapeLayer layer];
        minuteArcBg.path          = minutePath.CGPath;
        minuteArcBg.fillColor     = [UIColor clearColor].CGColor;
        minuteArcBg.lineCap       = kCALineCapSquare;
        minuteArcBg.strokeColor   = (hasBackgroundShadow ? [UIColor lightYellowColor].CGColor : [UIColor clearColor].CGColor);
        minuteArcBg.strokeEnd     = 1.0f;
        minuteArcBg.lineWidth     = [_lineWidth floatValue];
        minuteArcBg.zPosition     = -1;
        
        [self.layer addSublayer:_hourArc];
        [self.layer addSublayer:_minuteArc];
        [self.layer addSublayer:hourArcBg];
        [self.layer addSublayer:minuteArcBg];
        
    }
    return self;
}

- (void)stroke
{
    // Add Animation
    CABasicAnimation *hourAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    hourAnimation.duration          = _duration;
    hourAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    hourAnimation.fromValue         = @0.0f;
    hourAnimation.toValue           = [self valueForHH:_HH];
    _hourArc.strokeEnd              = [[self valueForHH:_HH] floatValue];
    _hourArc.strokeColor            = [_HH intValue] < 12 ? [UIColor dayHourArcColor].CGColor : [UIColor nightHourArcColor].CGColor;

    CABasicAnimation *minuteAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    minuteAnimation.duration          = _duration;
    minuteAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    minuteAnimation.fromValue         = @0.0f;
    minuteAnimation.toValue           = [self valueForMM:_MM];
    _minuteArc.strokeEnd              = [[self valueForMM:_MM] floatValue];
    _minuteArc.strokeColor            = [_HH intValue] < 12 ? [UIColor dayMinuteArcColor].CGColor : [UIColor nightMinuteArcColor].CGColor;
    
    [_hourArc addAnimation:hourAnimation forKey:@"strokeEndAnimation"];
    [_minuteArc addAnimation:minuteAnimation forKey:@"strokeEndAnimation"];
}

- (void)updateHH:(NSNumber *)hour MM:(NSNumber *)minute
{
    // Take care of the CAAnimation start order because of the presentation layer may snapping back to original values
    
    CAAnimationGroup *hourGroup = [CAAnimationGroup animation];
    if ([self shouldFillHourArc:hour]) {
        [hourGroup setDuration:2*_duration];

        CABasicAnimation *hourAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        hourAnimation1.duration          = _duration;
        hourAnimation1.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        hourAnimation1.fromValue         = [self valueForHH:_HH];
        hourAnimation1.toValue           = @1.0f;
        _hourArc.strokeColor             = [_HH intValue] < 12 ? [UIColor dayHourArcColor].CGColor : [UIColor nightHourArcColor].CGColor;

        CABasicAnimation *hourAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        hourAnimation2.duration          = _duration;
        hourAnimation2.beginTime         = _duration;
        hourAnimation2.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        hourAnimation2.fromValue         = @0.0f;
        hourAnimation2.toValue           = [self valueForHH:hour];
        _hourArc.strokeColor             = [hour intValue] < 12 ? [UIColor dayHourArcColor].CGColor : [UIColor nightHourArcColor].CGColor;

        _hourArc.strokeEnd               = [[self valueForHH:hour] floatValue];

        [hourGroup setAnimations:@[hourAnimation1, hourAnimation2]];
        
    } else {
        [hourGroup setDuration:_duration];
        
        CABasicAnimation *hourAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        hourAnimation.duration          = _duration;
        hourAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        hourAnimation.fromValue         = [self valueForHH:_HH];
        hourAnimation.toValue           = [self valueForHH:hour];
        _hourArc.strokeColor            = [hour intValue] < 12 ? [UIColor dayHourArcColor].CGColor : [UIColor nightHourArcColor].CGColor;
        
        _hourArc.strokeEnd              = [[self valueForHH:hour] floatValue];

        [hourGroup setAnimations:@[hourAnimation]];
    }
    
    _HH = hour;
    
    CAAnimationGroup *minuteGroup = [CAAnimationGroup animation];
    
    if ([self shouldFillMinuteArc:minute]) {
        [minuteGroup setDuration:2*_duration];
        
        CABasicAnimation *minuteAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        minuteAnimation1.duration          = _duration;
        minuteAnimation1.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        minuteAnimation1.fromValue         = [self valueForMM:_MM];
        minuteAnimation1.toValue           = @1.0f;
        _minuteArc.strokeColor             = [_HH intValue] < 12 ? [UIColor dayMinuteArcColor].CGColor : [UIColor nightMinuteArcColor].CGColor;

        CABasicAnimation *minuteAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        minuteAnimation2.duration          = _duration;
        minuteAnimation2.beginTime         = _duration;
        minuteAnimation2.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        minuteAnimation2.fromValue         = @0.0f;
        minuteAnimation2.toValue           = [self valueForMM:minute];
        _minuteArc.strokeColor             = [hour intValue] < 12 ? [UIColor dayMinuteArcColor].CGColor : [UIColor nightMinuteArcColor].CGColor;

        _minuteArc.strokeEnd               = [[self valueForMM:minute] floatValue];
        
        [minuteGroup setAnimations:@[minuteAnimation1, minuteAnimation2]];
        
    } else {
        [minuteGroup setDuration:_duration];
        
        CABasicAnimation *minuteAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        minuteAnimation.duration          = _duration;
        minuteAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        minuteAnimation.fromValue         = [self valueForMM:_MM];
        minuteAnimation.toValue           = [self valueForMM:minute];
        _minuteArc.strokeColor            = [hour intValue] < 12 ? [UIColor dayMinuteArcColor].CGColor : [UIColor nightMinuteArcColor].CGColor;
        
        _minuteArc.strokeEnd              = [[self valueForMM:minute] floatValue];
        
        [minuteGroup setAnimations:@[minuteAnimation]];
    }

    _MM = minute;
    
    [_hourArc addAnimation:hourGroup forKey:@"strokeEndAnimation"];
    [_minuteArc addAnimation:minuteGroup forKey:@"strokeEndAnimation"];
}

- (NSNumber *)valueForHH:(NSNumber *)hour
{
    return @([hour intValue] % 12 / 12.0f);
}

- (NSNumber *)valueForMM:(NSNumber *)minute
{
    return @([minute intValue] % 60 / 60.0f);
}

- (BOOL)shouldFillHourArc:(NSNumber *)hour
{
    if ([hour intValue] < 12 && [_HH intValue] < 12 && [hour intValue] >= [_HH intValue])
        return NO;
    if ([hour intValue] >= 12 && [_HH intValue] >= 12 && [hour intValue] >= [_HH intValue])
        return NO;
    return YES;
}

- (BOOL)shouldFillMinuteArc:(NSNumber *)minute
{
    if ([minute intValue] < [_MM intValue])
        return YES;
    else
        return NO;
}

@end