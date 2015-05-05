//
//  ZCalendarScroolView.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCalendar.h"


@interface ZCalendarView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>


- (instancetype)initWithFrame:(CGRect)frame headetViewClassName:(NSString *)headetViewClassName scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

/**
 *  视图样式
 */
@property(nonatomic, strong) ZCalendarStyle *zcalendarStyle;


// ZCalendarCollectionViewDelegate
@property(nonatomic, weak) id<ZCalendarDelegate>zCalendarDelegate;

@property(nonatomic, strong)UICollectionViewFlowLayout *layout;


/**
 *  开始时间
 */
@property(nonatomic, assign) NSInteger starYear;


/**
 *  结束时间
 */
@property(nonatomic, assign) NSInteger endYear;

/**
 *  选中的日期
 */
@property(nonatomic, strong) NSDate *selectDate;


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
 *  数据层
 */
@property(nonatomic, strong) NSMutableDictionary *dataArray;

/**
 *  滚动到对应日期
 *
 *  @param date
 */
- (void)scrollToItemAtDate:(NSDate *)date animated:(BOOL)animated;

- (void)setSelectDate:(NSDate *)selectDate animated:(BOOL)animated;

/**
 *  根据日期选择对应的 cell
 *
 *  @param date  日期
 *
 *  @return  return cell
 */
- (ZCalendarDrawViewCell *)getCalendarDrawViewCellByDate:(NSDate *)date;
@end
