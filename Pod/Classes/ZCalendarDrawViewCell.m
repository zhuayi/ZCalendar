//
//  ZCalendarDrawView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarDrawViewCell.h"
#import "ZCalendarModel.h"
#import "NSDate+ZCalendar.h"
#import "NSString+ZCalendar.h"
#import "UIView+ZQuartz.h"
@implementation ZCalendarDrawViewCell {
    
    CGFloat _dayCount;
    CGFloat _rowCount;
    
    CGFloat _columnWidth;
    NSInteger _interval;
    
    // 日期数组
    NSMutableArray *_dateArray;
    
    UIImageView *_cutOffRule;
    
    NSDateComponents *_selectDateComponents;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _columnWidth = self.frame.size.width / 7;
        _dateArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        _cutOffRule = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cut-off-rule"]];
        _cutOffRule.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width + 10, 2);
        _cutOffRule.hidden = YES;
        [self addSubview:_cutOffRule];
        
        return self;
    }
    return self;
}


// 获取月,年视图数据
- (void)getDateArrayByMonthYear {
    
    [_dateArray removeAllObjects];
    
    for (int i = 0; i < (_dayCount + _interval); i++) {
        
        if (i < _interval) {
            continue;
        }
        CGFloat x = _columnWidth * fmod(i , 7);
        CGFloat y = self.zcalendarStyle.monthRowHeight - 5 + _rowHeight * ceil(i / 7);
        
        ZCalendarModel *zcalendarModel = [[ZCalendarModel alloc] init];
        
        CGRect frame = CGRectMake(x, y, _columnWidth, _rowHeight);
        CGRectInset(frame, 0.95, 0.95);
        
        zcalendarModel.frame = CGRectInset(frame, 0.95, 0.95);
        
        zcalendarModel.date = [_firstDate getDateByDaysAgo:(i - _interval)];
        zcalendarModel.dateComponents = [zcalendarModel.date getDateComponentsByDate];
        
        zcalendarModel.dateText = [NSString stringWithFormat:@"%ld", zcalendarModel.dateComponents.day];
        
        [_dateArray addObject:zcalendarModel];
    }
}

- (void)setFirstDate:(NSDate *)firstDate {
    _firstDate = firstDate;
    
    _currentDateComponents = [firstDate getDateComponentsByDate];
    
    if (_caledarType == CalendarTypeWeek) {
        
        _rowCount = 1;
        
        _rowHeight = self.frame.size.height;
        
        _interval = 0;
        
        _dayCount = 7;
        
    } else {
        
        _dayCount = [firstDate getDays];
        
        if (_caledarType == CalendarTypeYear) {
            
            if (_currentDateComponents.month > 9) {
                
                _cutOffRule.hidden = YES;
            } else {
                
                _cutOffRule.hidden = NO;
            }
        } else {
            
            _cutOffRule.hidden = YES;
        }
        
        _interval = [_currentDateComponents weekday] - 1;
        if (_caledarType == CalendarTypeMonth) {
            
            _rowCount = ceil((_dayCount + _interval) / 7);
        } else {
            _rowCount = 6;
        }
        
        _rowHeight = (self.frame.size.height - self.zcalendarStyle.monthRowHeight) / _rowCount;
    }
    
    [self getDateArrayByMonthYear];
}

- (void)drawRect:(CGRect)rect {
    self.context = UIGraphicsGetCurrentContext();
    
    if (_zcalendarStyle.lineColor) {
        CGContextSetStrokeColorWithColor(self.context, _zcalendarStyle.lineColor.CGColor);
        
        // 月视图才显示横线
        if (_caledarType == CalendarTypeMonth) {
            for (int i = 1; i < 2; i++) {
                
                CGFloat intervalWidth = 0;
                if (i == 1) {
                    intervalWidth = _interval * _columnWidth;
                }
                
                CGContextMoveToPoint(self.context, intervalWidth, _rowHeight * i);
                CGContextAddLineToPoint(self.context, self.frame.size.width, _rowHeight * i);
                CGContextStrokePath(self.context);
            }
        }
    }
    
    
    for (ZCalendarModel *zcalendarModel in _dateArray) {
        
        if (_zcalendarStyle.dateTextStyle) {
            CGSize size = [zcalendarModel.dateText sizeWithAttributes:_zcalendarStyle.dateTextStyle];
            
            CGFloat textY = zcalendarModel.frame.origin.y;
            if (_caledarType == CalendarTypeWeek) {
                
                textY = textY +  ((_rowHeight / 2) - size.height) / 2;
                
            } else {
                textY = textY + _rowHeight - size.height - 4;
            }
            
            if (zcalendarModel.dateComponents.year == _selectDateComponents.year
                && zcalendarModel.dateComponents.month == _selectDateComponents.month
                && zcalendarModel.dateComponents.day == _selectDateComponents.day) {
                
                [self drawText:CGPointMake(zcalendarModel.frame.origin.x + (zcalendarModel.frame.size.width - size.width) / 2, textY)
                          text:zcalendarModel.dateText fontSize:_zcalendarStyle.dateTextSelectStyle];
            } else {
                [self drawText:CGPointMake(zcalendarModel.frame.origin.x + (zcalendarModel.frame.size.width - size.width) / 2, textY)
                          text:zcalendarModel.dateText fontSize:_zcalendarStyle.dateTextStyle];
            }
        }
        
        if ([self respondsToSelector:@selector(drawCustom:)]) {
            
            [self performSelector:@selector(drawCustom:) withObject:zcalendarModel];
        }
        
    }
    
    if (_zcalendarStyle.monthRowHeight > 0) {
        
        NSString *text = [NSString stringWithFormat:@"%ld月", (long)[_currentDateComponents month]];
        CGFloat drawMonthX = 0;
        if (_caledarType == CalendarTypeMonth) {
            drawMonthX = _interval * _columnWidth;
            if (_interval == 0) {
                drawMonthX = drawMonthX + 10;
            }
        }
        [self drawText:CGPointMake(drawMonthX, 0) text:text fontSize:_zcalendarStyle.monthTextStyle];
        CGSize size = [text sizeWithAttributes:_zcalendarStyle.dateTextStyle];
        if (_zcalendarStyle.cutLineImage) {
            
            [self drawImage:CGRectMake(_interval * _columnWidth, size.height + 5, self.frame.size.width, 2) image:_zcalendarStyle.cutLineImage];
        }
    }
}


- (void)setSelectDate:(NSDate *)selectDate {
    _selectDateComponents = [selectDate getDateComponentsByDate];
    _selectDate = selectDate;
    [self setNeedsDisplay];
}

/**
 *  根据坐标获取日期
 *
 *  @param point
 */
- (ZCalendarModel *)getDateByPoint:(CGPoint)point {
    
    @try {
        
        for (ZCalendarModel *zcalendarModel in _dateArray) {
            if (CGRectContainsPoint(zcalendarModel.frame,point)) {
                if (zcalendarModel.date) {
                    [self setSelectDate:zcalendarModel.date];
                    NSLog(@"zcalendarModel.date : %@", zcalendarModel.date);
                }
                return zcalendarModel;
                break;
            }
        }
        
    }
    @catch (NSException *exception) {
        
    }
    return nil;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
    
    if (_zcalendarStyle.isClick == NO) {
        return;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if (touch.tapCount == 1) {
        ZCalendarModel *zcalendarModel = [self getDateByPoint:touchPoint];
        [_delegate didClickDate:self zCalendarModel:zcalendarModel];
    }
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end
