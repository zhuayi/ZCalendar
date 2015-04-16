//
//  ZCalendarScroolView.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCalendarCollectionView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>

/**
 *  每个 cell 的高度
 */
@property(nonatomic, assign) CGFloat cellHeight;

/**
 *  开始时间
 */
@property(nonatomic, assign) NSInteger starYear;


/**
 *  结束时间
 */
@property(nonatomic, assign) NSInteger endYear;


/**
 *  设置日历区间
 *
 *  @param starDate 开始时间
 *  @param endData  结束时间
 */
- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData;
@end
