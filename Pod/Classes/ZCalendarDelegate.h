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
 *  从视图左上角开始,当前显示的日期,只包含年/月信息
 *
 *  @param date
 */
//- (void)didShowLeftTopCell:(ZCalendarDrawViewCell *)zcalendarDrawViewCell;

@end
