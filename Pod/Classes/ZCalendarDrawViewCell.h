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

@property(nonatomic) CGContextRef context;

@property(nonatomic, weak) id<ZCalendarDelegate> delegate;

/**
 *  当前日期
 */
@property(nonatomic, strong) NSDateComponents *currentDateComponents;

/**
 *  视图样式
 */
@property(nonatomic, weak) ZCalendarStyle *zcalendarStyle;


/**
 *  视图, 年,月,周
 */
@property(nonatomic, assign) CalendarType caledarType;

/**
 *  事件数据数组
 */
@property(nonatomic, weak) NSMutableDictionary *dataArray;


@property(nonatomic, strong) NSDate *firstDate;

/**
 *  选中的日期
 */
@property(nonatomic, strong) NSDate *selectDate;

/**
 *  日期宽度
 */
@property(nonatomic, assign, readonly) CGFloat columnWidth;

/**
 *  日期高度
 */
@property(nonatomic, assign, readonly) CGFloat rowHeight;


/**
 *  根据坐标获取日期
 *
 *  @param point
 */
- (ZCalendarModel *)getDateByPoint:(CGPoint)point;


@end
