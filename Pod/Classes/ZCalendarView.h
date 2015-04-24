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
@property(nonatomic, weak) id<ZCalendarCollectionViewDelegate>collectionViewDelegate;

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
@property(nonatomic, strong)NSMutableDictionary *dataArray;


@end
