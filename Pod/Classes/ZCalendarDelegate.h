//
//  ZCalendarDelegate.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/17.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCalendar.h"
@class ZCalendarDrawViewCell;
@protocol ZCalendarDelegate <NSObject>

/**
 *  选中日期回调
 *
 *  @param zcalendarDrawViewCell 选中的 Cell
 *  @param zcalendarModel         选中的 Cell 对象
 */
- (void)didClickDate:(ZCalendarDrawViewCell *)zCalendarDrawViewCell zCalendarModel:(ZCalendarModel *)zCalendarModel;

/**
 *  滚动到指定日期
 *
 *  @param date
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView date:(NSDate *)date caledarType:(CalendarType)caledarType;

@end
