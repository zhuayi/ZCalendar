//
//  YearCalendarView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/23.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "YearCalendarView.h"

@implementation YearCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    
//    self.zcalendarStyle.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 36)];
//    self.zcalendarStyle.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MonthHeader"]];
    
    self = [super initWithFrame:frame headetViewClassName:@"ZCalendarYearHeardView" scrollDirection:UICollectionViewScrollDirectionVertical];
    if (self) {
        
        self.zcalendarStyle.cellSize = CGSizeMake(95, 80);
        
        // cell边距
        self.zcalendarStyle.cellEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
        
        // 设置选中日期颜色
        self.zcalendarStyle.selectDateColor = [UIColor redColor];
        
        // 设置默认日期颜色
        self.zcalendarStyle.normalDateColoe = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // 设置显示的年视图
        self.caledarType = CalendarTypeYear;
        
        self.zcalendarStyle.monthRowHeight = 20;
        
        self.zcalendarStyle.sectionHeight = 20;
        
        
        /**
         *  设置月份文字颜色
         */
        self.zcalendarStyle.monthTextStyle = @{
                                               NSFontAttributeName: [UIFont systemFontOfSize:12.0],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]
                                               };
                
        // 设置日历显示区间, 要放在最下边
        [self setYearInterval:2010 endDate:[today year]];
        
    }
    return self;
}


@end
