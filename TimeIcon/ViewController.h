//
//  ViewController.h
//  TimeIcon
//
//  Created by Zhou Yifei on 13-9-29.
//  Copyright (c) 2013年 Zhou Yifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *hourText;
@property (weak, nonatomic) IBOutlet UITextField *minuteText;
- (IBAction)changeValue:(id)sender;

@end
