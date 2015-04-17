//
//  ZCalendarYearHeardView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/16.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarYearHeardView.h"

@implementation ZCalendarYearHeardView {
    
    UILabel *label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor brownColor];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label.textColor = [UIColor redColor];
        [self addSubview:label];
    }
    return self;
}


- (void)setYear:(NSInteger)year {
    _year = year;
    
    label.text = [NSString stringWithFormat:@"%ld年", _year];;
}

@end
