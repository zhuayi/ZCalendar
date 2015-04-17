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
    zcalendarView.cellSize = CGSizeMake(self.view.frame.size.width, 200);
    
    zcalendarView.delegate = self;
    
    // 线条颜色
    zcalendarView.zcalendarCollectionView.lineColor = [UIColor redColor];
    
    // cell边距
    zcalendarView.cellEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
    
    // 设置显示的年视图
    zcalendarView.caledarType = CalendarTypeMonth;
    
    // 设置日期文字颜色
    zcalendarView.zcalendarCollectionView.dateTextColor = [UIColor whiteColor];
    
    // 设置日历显示区间, 要放在最下边
    [zcalendarView setYearInterval:2010 endDate:[today year]];
    
    [self.view addSubview:zcalendarView];
}

#pragma mark - delegate
- (void)didClickdate:(ZCalendarDrawViewCell *)zcalendarDrawViewCell zcalendarModel:(ZCalendarModel *)zcalendarModel {
 
    NSLog(@"didClickDate : %@, zcalendarDrawViewCell: %@", zcalendarModel.dateText, zcalendarDrawViewCell);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
