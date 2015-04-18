//
//  ZCalendarScroolView.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCalendar.h"


@interface ZCalendarCollectionView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>

// ZCalendarCollectionViewDelegate
@property(nonatomic, weak) id<ZCalendarCollectionViewDelegate>collectionViewDelegate;

@property(nonatomic, strong)UICollectionViewFlowLayout *layout;

/**
 *  每个 cell 的高度
 */
@property(nonatomic, assign) CGSize cellSize;

/**
 *  开始时间
 */
@property(nonatomic, assign) NSInteger starYear;


/**
 *  结束时间
 */
@property(nonatomic, assign) NSInteger endYear;

/**
 *  cell 的间距
 */
@property(nonatomic, assign) UIEdgeInsets cellEdgeInsets;

/**
 *  视图, 年,月,周
 */
@property(nonatomic, assign) CalendarType caledarType;

/**
 *  设置日历区间
 *
 *  @param starDate 开始时间
 *  @param endData  结束时间
 */
- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData;

/**
 *  线条颜色
 */
@property(nonatomic, strong) UIColor *lineColor;

/**
 *  日期文字颜色
 */
@property(nonatomic, strong) UIColor *dateTextColor;

@end
