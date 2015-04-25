//
//  ZCalendarModel.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/17.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarModel.h"

@implementation ZCalendarModel


+ (NSString *)getWeekStringByWeekDay:(NSInteger)weekDay {
    
    NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    return [array objectAtIndex:weekDay];
}
@end
