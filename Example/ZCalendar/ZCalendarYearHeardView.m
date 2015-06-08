//
//  ZCalendarYearHeardView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/16.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarYearHeardView.h"
#import "ZCalendar.h"
@implementation ZCalendarYearHeardView {
    
    UILabel *label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:14.f];
        [self addSubview:label];
        
        UIImageView *cutOffRule = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cut-off-rule"]];
        cutOffRule.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 2);
        [self addSubview:cutOffRule];
    }
    return self;
}


- (void)setYear:(NSDate *)sender {
    
    if (sender) {
        label.text = [NSString stringWithFormat:@"%d年", [sender getDateComponentsByDate].year];
    }
}

@end
