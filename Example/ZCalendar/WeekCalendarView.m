//
//  WeekCalendarView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/24.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "WeekCalendarView.h"

@implementation WeekCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self.zcalendarStyle.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 36)];
    self.zcalendarStyle.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MonthHeader"]];
    
    self = [super initWithFrame:frame headetViewClassName:nil scrollDirection:UICollectionViewScrollDirectionHorizontal];
    if (self) {
        
        self.zcalendarStyle.cellSize = CGSizeMake(frame.size.width, 50);
        
        self.zcalendarCollectionView.pagingEnabled = YES;
             
        NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
        
        // 设置选中日期颜色
        self.zcalendarStyle.selectDateColor = [UIColor redColor];
        
        // 设置默认日期颜色
        self.zcalendarStyle.normalDateColoe = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
        
        // 设置显示的年视图
        self.caledarType = CalendarTypeWeek;
        
        self.zcalendarStyle.monthRowHeight = 0;
        
        // 设置日期文字颜色
        self.zcalendarStyle.dateTextStyle = @{
                                              NSFontAttributeName: [UIFont systemFontOfSize:12.0],
                                              NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
        
        
//        /**
//         *  设置月份文字颜色
//         */
//        //        self.zcalendarStyle.monthTextColor = [UIColor whiteColor];
//        self.zcalendarStyle.monthTextStyle = @{
//                                               NSFontAttributeName: [UIFont systemFontOfSize:14.0],
//                                               NSForegroundColorAttributeName: [UIColor whiteColor]
//                                               };
        
//        self.zcalendarStyle.cutLineImage = [UIImage imageNamed:@"cut-off-rule"];
        
        // 设置日历显示区间, 要放在最下边
        [self setYearInterval:2015 endDate:[today year]];
        
    }
    return self;
}


@end
