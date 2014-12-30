//
//  TimeIconView.h
//  TimeIcon
//
//  Created by Zhou Yifei on 13-10-7.
//  Copyright (c) 2013年 Zhou Yifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeIconView : UIView

@property (assign, nonatomic) NSUInteger HH;
@property (assign, nonatomic) NSUInteger MM;

- (void)drawInContext:(CGContextRef)context withHH:(NSUInteger)hour andMM:(NSUInteger)minute;

- (void)setHH:(NSUInteger)hour andMM:(NSUInteger)minute;

@end
