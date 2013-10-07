//
//  TimeIconView.h
//  TimeIcon
//
//  Created by Zhou Yifei on 13-10-7.
//  Copyright (c) 2013年 Zhou Yifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeIconView : UIView

@property (assign, nonatomic) int HH;
@property (assign, nonatomic) int MM;

- (void)drawInContext:(CGContextRef)context withHH:(int)hour andMM:(int)minute;

@end
