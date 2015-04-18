//
//  ZCalendarStyle.h
//  ZCalendar
//
//  Created by zhuayi on 15/4/18.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZCalendarStyle : NSObject

/**
 *  头部 view
 */
@property(nonatomic, strong) UIView *header;


/**
 *  每个 cell 的高度
 */
@property(nonatomic, assign) CGSize cellSize;


/**
 *  cell 的间距
 */
@property(nonatomic, assign) UIEdgeInsets cellEdgeInsets;


/**
 *  线条颜色
 */
@property(nonatomic, strong) UIColor *lineColor;

/**
 *  日期文字颜色
 */
@property(nonatomic, strong) UIColor *dateTextColor;


/**
 *  选中日期颜色
 */
@property(nonatomic, strong) UIColor *selectDateColor;

/**
 *  默认日期颜色
 */
@property(nonatomic, strong) UIColor *normalDateColoe;

@end
