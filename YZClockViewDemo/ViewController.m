//
//  ViewController.m
//  YZClockViewDemo
//
//  Created by Yifei Zhou on 1/3/15.
//  Copyright (c) 2015 Yifei Zhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

#import "ViewController.h"
#import "YZClockView.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) YZClockView *bigClock;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _hourText.delegate = self;
    _minuteText.delegate = self;
    
    YZClockView *amClock = [[YZClockView alloc] initWithFrame:CGRectMake(50, 50, 90, 90)
                                                             HH:@7
                                                             MM:@10
                                                         shadow:YES];
    [amClock stroke];
    
    YZClockView *pmClock = [[YZClockView alloc] initWithFrame:CGRectMake(170, 50, 90, 90)
                                                             HH:@18
                                                             MM:@40
                                                         shadow:YES];
    [pmClock stroke];
    
    _bigClock = [[YZClockView alloc] initWithFrame:CGRectMake(50, 200, 210, 210) HH:@10 MM:@30 shadow:YES];
    [_bigClock stroke];
    
    [self.view addSubview:amClock];
    [self.view addSubview:pmClock];
    [self.view addSubview:_bigClock];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeValue:(id)sender
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [_bigClock updateHH:[formatter numberFromString:_hourText.text] MM:[formatter numberFromString:_minuteText.text]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end