//
//  ZCalendarDate.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/16.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCalendarDate : NSObject

/**
 *  获取时间格式
 *
 *  @return 
 */
+ (NSDateFormatter *)getFormatter;

/**
 *  根据日期字符串获取是周几,月份,年等信息
 *
 *  @param date 日期字符串  2015-4-1
 *
 *  @return 周日为0,以此类推
 */
+ (NSDateComponents *)getDateComponentsByDate:(NSDate *)date;

/**
 *  获取当前日期
 *
 *  @return  strings
 */
+ (NSString *)getNowDate;

/**
 *  获取当前时间戳
 *
 *  @return NSTimeInterval
 */
+ (NSTimeInterval)getNowtimeIntervalSince1970;

/**
 *  获取某一个月多少天
 *
 *  @return NSInteger
 */
+ (NSInteger)getDays:(NSDate *)date;


@end
