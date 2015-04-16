//
//  ZCalendarView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarView.h"
#import "ZCalendarDate.h"
@implementation ZCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        header.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:header];
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        _zcalendarCollectionView = [[ZCalendarCollectionView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30) collectionViewLayout:flowLayout];
        
        
        NSDateComponents *today = [ZCalendarDate getDateComponentsByDate:[NSDate date]];
        [_zcalendarCollectionView setYearInterval:1970 endDate:[today year]];
        [self addSubview:_zcalendarCollectionView];

    }
    return self;
}

@end
