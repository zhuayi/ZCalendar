//
//  ZCalendarDrawView.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCalendar.h"

@interface ZCalendarDrawViewCell : UICollectionViewCell<ZCalendarDelegate>

@property(nonatomic) CGContextRef context;

@property(nonatomic, weak) id<ZCalendarDelegate> delegate;

/**
 *  当前日期
 */
@property(nonatomic, strong) NSDateComponents *currentDateComponents;

/**
 *  视图样式
 */
@property(nonatomic, strong) ZCalendarStyle *zcalendarStyle;


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
 *  日期宽度
 */
@property(nonatomic, assign) CGFloat columnWidth;

/**
 *  日期高度
 */
@property(nonatomic, assign) CGFloat rowHeight;
/**
 *  绘制文字
 *
 *  @param point     文字坐标
 *  @param text      文字
 *  @param fontStyle 文字样式
 */
- (void)drawText:(CGPoint)point text:(NSString *)text fontSize:(NSDictionary *)fontStyle;



/**
 *  根据坐标获取日期
 *
 *  @param point
 */
- (ZCalendarModel *)getDateByPoint:(CGPoint)point;


@end
