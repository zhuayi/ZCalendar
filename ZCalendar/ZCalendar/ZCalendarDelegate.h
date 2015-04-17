//
//  ZCalendarDelegate.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/17.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCalendarDrawViewCell;
@protocol ZCalendarDelegate <NSObject>

- (void)didClickdate:(ZCalendarDrawViewCell *)zcalendarDrawViewCell zcalendarModel:(ZCalendarModel *)zcalendarModel;


@end
