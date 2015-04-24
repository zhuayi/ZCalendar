//
//  NSDate+ZCalendar.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/17.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "NSDate+ZCalendar.h"

@implementation NSDate(ZCalendar)


/**
 *  根据日期字符串获取是周几,月份,年等信息
 *
 *  @param date 日期字符串  2015-4-1
 *
 *  @return 周日为0,以此类推
 */
- (NSDateComponents *)getDateComponentsByDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
//    [formatter setTimeZone:timeZone];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [calendar components:unitFlags fromDate:self];
}


- (NSDateFormatter *)getFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return formatter;
}

/**
 *  取 N 天前
 *
 *  @param days  N 天前
 *
 *  @return
 */
- (NSDate *)getDateByDaysAgo:(NSInteger )days {

    return [NSDate dateWithTimeInterval:days * 86400 sinceDate:self];
}


/**
 *  获取某一个月多少天
 *
 *  @return NSInteger
 */
- (NSInteger)getDays {
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    return days.length;
}

- (NSString *)dateTostring {
    return [[self getFormatter] stringFromDate:self];

}

@end
