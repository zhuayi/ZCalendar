//
//  ZViewController.m
//  ZCalendar
//
//  Created by renxin on 04/18/2015.
//  Copyright (c) 2014 renxin. All rights reserved.
//

#import "ZViewController.h"
#import "MonthCalendarView.h"
#import "YearCalendarView.h"
#import "WeekCalendarView.h"

@interface ZViewController ()

@end

@implementation ZViewController {
    UILabel *titleView;
    WeekCalendarView *weekCalendarView;
    YearCalendarView *YeraCalendarView;
    MonthCalendarView *monthCalendarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 64)];
    titleView.text = @"日历";
    titleView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleView];
    
    NSString *jsonString = @"{\"error\":0,\"data\":{\"2015-03-14\":{\"aqi\":132},\"2015-03-15\":{\"aqi\":137},\"2015-04-20\":{\"aqi\":90},\"2015-04-21\":{\"aqi\":91},\"2015-04-22\":{\"aqi\":85},\"2015-04-23\":{\"aqi\":80},\"2015-04-24\":{\"aqi\":107}}}";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *data2 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50 - 36, self.view.frame.size.width, 36)];
//    header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MonthHeader"]];
//    [self.view addSubview:header];
    
    weekCalendarView = [[WeekCalendarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    weekCalendarView.zCalendarDelegate = self;
    [self.view addSubview:weekCalendarView];
    weekCalendarView.dataArray = [data2 objectForKey:@"data"];
    
    
    YeraCalendarView = [[YearCalendarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    YeraCalendarView.zCalendarDelegate = self;
    [self.view addSubview:YeraCalendarView];
    YeraCalendarView.dataArray = [data2 objectForKey:@"data"];
    
    monthCalendarView = [[MonthCalendarView alloc] initWithFrame:CGRectMake(0, 264, self.view.frame.size.width, 200)];
    monthCalendarView.zCalendarDelegate = self;
    [self.view addSubview:monthCalendarView];
    monthCalendarView.dataArray = [data2 objectForKey:@"data"];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:39./255. green:158.0 / 255.0 blue:133.0 / 255.0 alpha:1.0];
}

#pragma mark - delegate
- (void)didClickDate:(ZCalendarDrawViewCell *)zCalendarDrawViewCell zCalendarModel:(ZCalendarModel *)zCalendarModel {
    
//    titleView.text = [zcalendarModel.date dateTostring];
    if (zCalendarDrawViewCell.caledarType == CalendarTypeYear) {
        
        NSLog(@"didClickDate : %@, %ld", zCalendarDrawViewCell, zCalendarDrawViewCell.currentDateComponents.year);
        
        [monthCalendarView scrollToItemAtDate:zCalendarDrawViewCell.firstDate];
    }
    if (zCalendarDrawViewCell.caledarType == CalendarTypeMonth) {
        
        NSLog(@"didClickDate : %@, %ld", zCalendarDrawViewCell, zCalendarDrawViewCell.currentDateComponents.year);
        
        if (zCalendarModel.date) {
            weekCalendarView.selectDate = zCalendarModel.date;
            [weekCalendarView reloadData];
//            [self setContentOffset:CGPointMake(0, 0) animated:YES];
//            [_zCalendarDelegate didClickDate:zCalendarDrawViewCell zCalendarModel:zCalendarModel];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView date:(NSDate *)date caledarType:(CalendarType)caledarType{
    
    NSLog(@"date : caledarType : %ld, %@", caledarType , date);
}

- (void)didShowLeftTopCell:(ZCalendarDrawViewCell *)zcalendarDrawViewCell {
    
//    NSLog(@"左上角日期: %ld - %ld", [zcalendarDrawViewCell.currentDateComponents year], [zcalendarDrawViewCell.currentDateComponents month]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end