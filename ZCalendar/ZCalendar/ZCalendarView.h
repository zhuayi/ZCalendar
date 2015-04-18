//
//  ZCalendarView.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCalendar.h"

@interface ZCalendarView : UIView

/**
 *  视图样式
 */
@property(nonatomic, strong) ZCalendarStyle *zcalendarStyle;

/**
 *  代理
 */
@property(nonatomic, weak) id<ZCalendarDelegate, ZCalendarCollectionViewDelegate> delegate;


@property(nonatomic, strong) ZCalendarCollectionView *zcalendarCollectionView;



/**
 *  视图类型,年/月/周
 */
@property(nonatomic, assign) CalendarType caledarType;

- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData;

@end
