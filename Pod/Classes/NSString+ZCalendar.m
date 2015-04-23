//
//  NSString+ZCalendar.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/17.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "NSString+ZCalendar.h"

@implementation NSString(ZCalendar)


/**
 *  根据时间戳返回时间
 *
 *  @return date
 */
- (NSDate *)dateFromString {
    
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [formatter setTimeZone:timeZone];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        return [formatter dateFromString:self];

    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        
    }
    return nil;
}
@end
