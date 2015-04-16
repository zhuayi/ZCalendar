//
//  ViewController.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ViewController.h"
#import "ZCalendarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZCalendarView *zcalendarView = [[ZCalendarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    zcalendarView.zcalendarCollectionView.cellHeight = self.view.frame.size.height / 2;
//    zcalendarScroolView.pageCount = 10;
    [self.view addSubview:zcalendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
