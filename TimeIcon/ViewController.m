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

@property (weak, nonatomic) IBOutlet TimeIconView *clockView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.clockView.HH = 18;
    self.clockView.MM = 30;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
