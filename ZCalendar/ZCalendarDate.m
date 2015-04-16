//
//  ZCalendarDate.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/16.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarDate.h"

@implementation ZCalendarDate

+ (NSDateFormatter *)getFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return formatter;
}

/**
 *  根据日期字符串获取是周几,月份,年等信息
 *
 *  @param date 日期字符串  2015-4-1
 *
 *  @return 周日为0,以此类推
 */
+ (NSDateComponents *)getDateComponentsByDate:(NSDate *)date {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [calendar components:unitFlags fromDate:date];
}

+ (NSString *)getNowDate {
    
    NSDateFormatter *formatter = [ZCalendarDate getFormatter];
    NSDate *now = [NSDate date];
    return [formatter stringFromDate:now];
}

+ (NSTimeInterval)getNowtimeIntervalSince1970 {
    
    return [[NSDate date] timeIntervalSince1970];
}

/**
 *  获取某一个月多少天
 *
 *  @return NSInteger
 */
+ (NSInteger)getDays:(NSDate *)date {
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    return days.length;
}
@end
