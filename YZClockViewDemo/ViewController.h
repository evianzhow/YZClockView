//
//  ViewController.h
//  YZClockViewDemo
//
//  Created by Yifei Zhou on 1/3/15.
//  Copyright (c) 2015 Yifei Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *hourText;
@property (weak, nonatomic) IBOutlet UITextField *minuteText;
- (IBAction)changeValue:(id)sender;

@end