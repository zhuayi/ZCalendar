//
//  ZCalendarModel.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/17.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZCalendarModel : NSObject


/**
 *  日历对象的尺寸坐标
 */
@property(nonatomic, assign) CGRect frame;

/**
 *  矩形颜色
 */
@property(nonatomic, strong) UIColor *rectangleColor;

/**
 *  日期
 */
@property(nonatomic, strong) NSString *dateText;


/**
 *  日期
 */
@property(nonatomic, strong) NSDateComponents *dateComponents;


@property(nonatomic, strong) NSDate *date;


@end
