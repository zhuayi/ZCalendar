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
    
    self.zcalendarStyle.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 36)];
    self.zcalendarStyle.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MonthHeader"]];
    
    self = [super initWithFrame:frame headetViewClassName:nil scrollDirection:UICollectionViewScrollDirectionVertical];
    if (self) {
        
        self.zcalendarStyle.cellSize = CGSizeMake(frame.size.width, 265);
        
        // 线条颜色
//        self.zcalendarStyle.lineColor = [UIColor greenColor];
        
        // cell边距
        self.zcalendarStyle.cellEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
        
        // 设置选中日期颜色
        self.zcalendarStyle.selectDateColor = [UIColor redColor];
        
        // 设置默认日期颜色
        self.zcalendarStyle.normalDateColoe = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // 设置显示的年视图
        self.caledarType = CalendarTypeMonth;
        
        self.zcalendarStyle.monthRowHeight = 30;
    
        // 设置日期文字颜色
        self.zcalendarStyle.dateTextStyle = @{
                                              NSFontAttributeName: [UIFont systemFontOfSize:12.0],
                                              NSForegroundColorAttributeName: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4]
                                              };
        
        // 设置日期文字颜色
        self.zcalendarStyle.dateTextSelectStyle = @{
                                                  NSFontAttributeName: [UIFont systemFontOfSize:12.0],
                                                  NSForegroundColorAttributeName: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
                                                  };
        
        self.selectDate = [NSDate date];
        
        
        /**
         *  设置月份文字颜色
         */
//        self.zcalendarStyle.monthTextColor = [UIColor whiteColor];
        self.zcalendarStyle.monthTextStyle = @{
                                                NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                                NSForegroundColorAttributeName: [UIColor whiteColor]
                                                };
        
        self.zcalendarStyle.cutLineImage = [UIImage imageNamed:@"cut-off-rule"];
        
        // 设置日历显示区间, 要放在最下边
        [self setYearInterval:2014 endDate:[today year]];
        
    }
    return self;
}

@end
