//
//  TimeIconView.h
//  TimeIcon
//
//  Created by Zhou Yifei on 13-10-7.
//  Copyright (c) 2013年 Zhou Yifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+TimeIconView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface YZClockView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                           HH:(NSNumber *)hour
                           MM:(NSNumber *)minute
                       shadow:(BOOL)hasBackgroundShadow;
- (void)updateHH:(NSNumber *)hour MM:(NSNumber *)minute;
- (void)stroke;

@property (nonatomic) NSNumber *HH;
@property (nonatomic) NSNumber *MM;
@property (nonatomic) NSNumber *lineWidth;
@property (nonatomic) NSTimeInterval duration;

@end
