//
//  TimeIconView.m
//  TimeIcon
//
//  Created by Zhou Yifei on 13-10-7.
//  Copyright (c) 2013年 Zhou Yifei. All rights reserved.
//

#import "TimeIconView.h"

@interface TimeIconView ()

@property (nonatomic) CAShapeLayer *hourArc;
@property (nonatomic) CAShapeLayer *minuteArc;

@end

@implementation TimeIconView

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
        
        UIBezierPath *hourPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:radius startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:YES];
        _hourArc = [CAShapeLayer layer];
        _hourArc.path = hourPath.CGPath;
        _hourArc.lineCap = kCALineCapSquare;
        _hourArc.fillColor = [UIColor clearColor].CGColor;
        _hourArc.lineWidth = [_lineWidth floatValue];
        _hourArc.zPosition = 1;
        
        UIBezierPath *minutePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:radius*0.8f startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:YES];
        _minuteArc = [CAShapeLayer layer];
        _minuteArc.path = minutePath.CGPath;
        _minuteArc.lineCap = kCALineCapSquare;
        _minuteArc.fillColor = [UIColor clearColor].CGColor;
        _minuteArc.lineWidth = [_lineWidth floatValue];
        _minuteArc.zPosition = 1;
        
        // Hour Arc Background
        CAShapeLayer *hourArcBg = [CAShapeLayer layer];
        hourArcBg.path = hourPath.CGPath;
        hourArcBg.fillColor = [UIColor clearColor].CGColor;
        hourArcBg.lineCap = kCALineCapSquare;
        hourArcBg.strokeColor = (hasBackgroundShadow ? [UIColor lightYellowColor].CGColor : [UIColor clearColor].CGColor);
        hourArcBg.strokeEnd = 1.0f;
        hourArcBg.lineWidth = [_lineWidth floatValue];
        hourArcBg.zPosition = -1;
        
        // Minute Arc Background
        CAShapeLayer *minuteArcBg = [CAShapeLayer layer];
        minuteArcBg.path = minutePath.CGPath;
        minuteArcBg.fillColor = [UIColor clearColor].CGColor;
        minuteArcBg.lineCap = kCALineCapSquare;
        minuteArcBg.strokeColor = (hasBackgroundShadow ? [UIColor lightYellowColor].CGColor : [UIColor clearColor].CGColor);
        minuteArcBg.strokeEnd = 1.0f;
        minuteArcBg.lineWidth = [_lineWidth floatValue];
        minuteArcBg.zPosition = -1;
        
        [self.layer addSublayer:_hourArc];
        [self.layer addSublayer:_minuteArc];
        [self.layer addSublayer:hourArcBg];
        [self.layer addSublayer:minuteArcBg];
        
    }
    return self;
}

- (void)stroke
{
#ifdef DEBUG
    NSLog(@"%f, %f", self.center.x, self.center.y);
    [self.layer setBorderColor:[UIColor redColor].CGColor];
    [self.layer setBorderWidth:1.0f];
#endif
    // Add Animation
    CABasicAnimation *hourAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    hourAnimation.duration = _duration;
    hourAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    hourAnimation.fromValue = @0.0f;
    hourAnimation.toValue = @(([_HH intValue] % 12) / 12.0f);
    _hourArc.strokeEnd = [_HH intValue] % 12 / 12.0f;
    _hourArc.strokeColor = [_HH intValue] < 12 ? [UIColor dayHourArcColor].CGColor : [UIColor nightHourArcColor].CGColor;
    
    CABasicAnimation *minuteAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    minuteAnimation.duration = _duration;
    minuteAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    minuteAnimation.fromValue = @0.0f;
    minuteAnimation.toValue = @([_MM intValue] / 60.0f);
    _minuteArc.strokeEnd = [_MM intValue] / 60.0f;
    _minuteArc.strokeColor = [_HH intValue] < 12 ? [UIColor dayMinuteArcColor].CGColor : [UIColor nightMinuteArcColor].CGColor;
    
    [_hourArc addAnimation:hourAnimation forKey:@"strokeEndAnimation"];
    [_minuteArc addAnimation:minuteAnimation forKey:@"strokeEndAnimation"];
}

- (void)updateHH:(NSNumber *)hour MM:(NSNumber *)minute
{
    // Take care of the CAAnimation start order because of the presentation layer may snapping back to original values
    CABasicAnimation *hourAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    hourAnimation.duration = _duration;
    hourAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    hourAnimation.fromValue = @(([_HH intValue] % 12) / 12.0f);
    hourAnimation.toValue = @(([hour intValue] % 12) / 12.0f);
    _hourArc.strokeEnd = ([hour intValue] % 12) / 12.0f;
    _hourArc.strokeColor = [hour intValue] < 12 ? [UIColor dayHourArcColor].CGColor : [UIColor nightHourArcColor].CGColor;
    _HH = hour;
    
    CABasicAnimation *minuteAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    minuteAnimation.duration = _duration;
    minuteAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    minuteAnimation.fromValue = @([_MM intValue] / 60.0f);
    minuteAnimation.toValue = @([minute intValue] / 60.0f);
    _minuteArc.strokeEnd   = [minute intValue] / 60.0f;
    _minuteArc.strokeColor = [hour intValue] < 12 ? [UIColor dayMinuteArcColor].CGColor : [UIColor nightMinuteArcColor].CGColor;
    _MM = minute;
    
    [_hourArc addAnimation:hourAnimation forKey:@"strokeEndAnimation"];
    [_minuteArc addAnimation:minuteAnimation forKey:@"strokeEndAnimation"];
}
@end