//
//  ViewController.m
//  TimeIcon
//
//  Created by Zhou Yifei on 13-9-29.
//  Copyright (c) 2013年 Zhou Yifei. All rights reserved.
//

#import "ViewController.h"
#import "TimeIconView.h"

@interface ViewController ()

@property (nonatomic, strong) TimeIconView *bigClock;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    TimeIconView *amClock = [[TimeIconView alloc] initWithFrame:CGRectMake(50, 50, 90, 90)
                                                             HH:@7
                                                             MM:@10
                                                         shadow:YES];
    [amClock stroke];
    
    TimeIconView *pmClock = [[TimeIconView alloc] initWithFrame:CGRectMake(170, 50, 90, 90)
                                                             HH:@18
                                                             MM:@40
                                                         shadow:YES];
    [pmClock stroke];
    
    _bigClock = [[TimeIconView alloc] initWithFrame:CGRectMake(50, 200, 210, 210) HH:@10 MM:@30 shadow:YES];
    [_bigClock stroke];
    
    [self.view addSubview:amClock];
    [self.view addSubview:pmClock];
    [self.view addSubview:_bigClock];
    
    //Gesture
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeValue)];
    [self.view addGestureRecognizer:tapRecog];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeValue
{
    NSLog(@"Detect Swipe!\n");
    [_bigClock updateHH:@13 MM:@10];
}

@end
