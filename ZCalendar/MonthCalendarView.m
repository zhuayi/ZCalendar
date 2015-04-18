//
//  yearCalendarView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/18.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "MonthCalendarView.h"

@implementation MonthCalendarView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.cellSize = CGSizeMake(frame.size.width, 200);
        
        // 线条颜色
        self.zcalendarCollectionView.lineColor = [UIColor redColor];
        
        // cell边距
        self.cellEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
        
        // 设置显示的年视图
        self.caledarType = CalendarTypeMonth;
        
        // 设置日期文字颜色
        self.zcalendarCollectionView.dateTextColor = [UIColor whiteColor];
        
        // 设置日历显示区间, 要放在最下边
        [self setYearInterval:2010 endDate:[today year]];
        
        self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        self.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MonthHeader"]];
    }
    return self;
}

@end
