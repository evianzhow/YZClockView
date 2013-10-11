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
    
    TimeIconView *amClock = [[TimeIconView alloc] initWithFrame:CGRectMake(50, 50, 90, 90)];
    amClock.HH = 7;
    amClock.MM = 10;
    amClock.backgroundColor = [UIColor whiteColor];
    
    TimeIconView *pmClock = [[TimeIconView alloc] initWithFrame:CGRectMake(170, 50, 90, 90)];
    pmClock.HH = 18;
    pmClock.MM = 40;
    pmClock.backgroundColor = [UIColor whiteColor];
    
    _bigClock = [[TimeIconView alloc] initWithFrame:CGRectMake(50, 200, 210, 210)];
    _bigClock.HH = 10;
    _bigClock.MM = 30;
    _bigClock.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:amClock];
    [self.view addSubview:pmClock];
    [self.view addSubview:_bigClock];
    
    //Gesture
    UISwipeGestureRecognizer *swipeGest = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToChange)];
    [self.view addGestureRecognizer:swipeGest];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipeToChange
{
    NSLog(@"Detect Swipe!\n");
    [_bigClock setHH:4 andMM:15];
}

@end
