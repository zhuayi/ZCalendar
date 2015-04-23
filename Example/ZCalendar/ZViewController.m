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
@interface ZViewController ()

@end

@implementation ZViewController {
    UILabel *titleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 64)];
    titleView.text = @"日历";
    titleView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleView];
    
    
    
    YearCalendarView *monthCalendarView = [[YearCalendarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 374, self.view.frame.size.width, 374)];
    monthCalendarView.delegate = self;
    
    

    NSDictionary *data = @{ @"2015-4-15": @"50", @"2015-4-16": @"150" , @"2015-4-17": @"150" };
    [monthCalendarView.dataArray setValue:data forKey:@"2015-4"];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:39./255. green:158.0 / 255.0 blue:133.0 / 255.0 alpha:1.0];
    [self.view addSubview:monthCalendarView];
}

#pragma mark - delegate
- (void)didClickDate:(ZCalendarModel *)zcalendarModel {
    
    titleView.text = [NSString stringWithFormat:@"%ld - %ld - %ld", zcalendarModel.dateComponents.year, zcalendarModel.dateComponents.month, zcalendarModel.dateComponents.day];
    NSLog(@"didClickDate : %@", zcalendarModel.dateComponents);
}

- (void)didShowLeftTopCell:(ZCalendarDrawViewCell *)zcalendarDrawViewCell {
    
    NSLog(@"左上角日期: %ld - %ld", [zcalendarDrawViewCell.currentDateComponents year], [zcalendarDrawViewCell.currentDateComponents month]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end