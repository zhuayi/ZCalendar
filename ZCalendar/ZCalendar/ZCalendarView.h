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
 *  头部 view
 */
@property(nonatomic, strong) UIView *header;

/**
 *  代理
 */
@property(nonatomic, weak) id<ZCalendarDelegate, ZCalendarCollectionViewDelegate> delegate;


@property(nonatomic, strong) ZCalendarCollectionView *zcalendarCollectionView;


/**
 *  每个 cell 的高度
 */
@property(nonatomic, assign) CGSize cellSize;

/**
 *  cell 的间距
 */
@property(nonatomic, assign) UIEdgeInsets cellEdgeInsets;

/**
 *  视图类型,年/月/周
 */
@property(nonatomic, assign) CalendarType caledarType;

- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData;

@end
