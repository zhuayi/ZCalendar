//
//  ZCalendar.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/17.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

typedef NS_ENUM(NSInteger, CalendarType) {
    //以下是枚举成员
    CalendarTypeYear, // 年视图
    CalendarTypeMonth, // 月视图
    CalendarTypeWeek   // 周
};



#define kZCalendarCellViewClick @"kZCalendarCellViewClick"

#define kZcalendarCellNeedsDisplay @"kZcalendarCellNeedsDisplay"


#import "DateFormatterHelp.h"
#import "ZCalendarStyle.h"
#import "ZCalendarModel.h"
#import "ZCalendarDelegate.h"

#import "ZCalendarView.h"
#import "NSDate+ZCalendar.h"
#import "NSString+ZCalendar.h"

#import "ZCalendarDrawViewCell.h"