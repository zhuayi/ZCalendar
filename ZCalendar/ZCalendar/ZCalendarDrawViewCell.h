//
//  ZCalendarDrawView.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCalendar.h"

@interface ZCalendarDrawViewCell : UICollectionViewCell

/**
 *  当前日期
 */
@property(nonatomic, strong) NSDateComponents *currentDateComponents;

/**
 *  视图, 年,月,周
 */
@property(nonatomic, assign) CalendarType caledarType;

/**
 *  线条颜色
 */
@property(nonatomic, strong) UIColor *lineColor;

/**
 *  日期文字颜色
 */
@property(nonatomic, strong) UIColor *dateTextColor;

/**
 *  日期数组
 */
@property(nonatomic, strong) NSMutableArray *dateArray;

/**
 *  设置日期
 *
 *  @param date
 */
- (void)setDate:(NSDate *)date;


/**
 *  根据坐标获取日期
 *
 *  @param point
 */
- (ZCalendarModel *)getDateByPoint:(CGPoint)point;


@end
