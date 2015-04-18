//
//  ViewController.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ViewController.h"
#import "MonthCalendarView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    MonthCalendarView *monthCalendarView = [[MonthCalendarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    
    monthCalendarView.delegate = self;
    
    
    
    [self.view addSubview:monthCalendarView];
}

#pragma mark - delegate
- (void)didClickDate:(ZCalendarDrawViewCell *)zcalendarDrawViewCell zcalendarModel:(ZCalendarModel *)zcalendarModel {
 
    NSLog(@"didClickDate : %@, zcalendarDrawViewCell: %@", zcalendarModel.dateText, zcalendarDrawViewCell);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
