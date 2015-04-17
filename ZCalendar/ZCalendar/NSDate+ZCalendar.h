//
//  NSDate+ZCalendar.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/17.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(ZCalendar)


/**
 *  根据日期字符串获取是周几,月份,年等信息
 *
 *  @param date 日期字符串  2015-4-1
 *
 *  @return 周日为0,以此类推
 */
- (NSDateComponents *)getDateComponentsByDate;


/**
 *  获取某一个月多少天
 *
 *  @return NSInteger
 */
- (NSInteger)getDays;
@end
