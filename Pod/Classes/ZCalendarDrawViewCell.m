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
#import "ZCalendarDrawViewCell+Custom.h"

@implementation ZCalendarDrawViewCell {

    CGFloat _dayCount;
    CGFloat _rowCount;
    
    CGFloat _columnWidth;
    CGFloat _rowHeight;
    NSInteger _interval;
    
    // 日期数组
    NSMutableArray *_dateArray;
    
    UIImageView *_cutOffRule;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _columnWidth = self.frame.size.width / 7;
        _dateArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        if (_caledarType == CalendarTypeYear) {
          
            _cutOffRule = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cut-off-rule"]];
            _cutOffRule.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width + 10, 2);
            _cutOffRule.hidden = YES;
            [self addSubview:_cutOffRule];
        }
        

        return self;
    }
    return self;
}


- (void)setNeedsDisplay {
    
    CGSize rectangleSize = CGSizeMake(_columnWidth * 0.95 , _rowHeight * 0.95);
    for (int i = 0; i< (_dayCount + _interval); i++) {
        
        if (i < _interval) {
            continue;
        }
        CGFloat x = _columnWidth * fmod(i , 7);
        CGFloat y = self.zcalendarStyle.monthRowHeight - 5 + _rowHeight * ceil(i / 7);
        
        ZCalendarModel *zcalendarModel = [[ZCalendarModel alloc] init];
        zcalendarModel.frame = CGRectMake(x + (_columnWidth - rectangleSize.width) / 2,
                                          y + (_rowHeight - rectangleSize.height) / 2,
                                          rectangleSize.width,
                                          rectangleSize.height);
        
        NSInteger day = i + 1 - _interval;
        
        
        zcalendarModel.dateComponents = [[[NSString stringWithFormat:@"%ld-%ld-%ld",
                                           (long)[_currentDateComponents year],
                                           (long)[_currentDateComponents month],
                                           (long)day]
                                          dateFromString]
                                         getDateComponentsByDate];
        
        zcalendarModel.dateText = [NSString stringWithFormat:@"%ld", (long)day];
        
        
        if ([_dataArray objectForKey:[NSString stringWithFormat:@"%ld-%ld-%ld", _currentDateComponents.year, _currentDateComponents.month, day]]) {
        
            zcalendarModel.data = [_dataArray objectForKey:[NSString stringWithFormat:@"%ld-%ld-%ld", _currentDateComponents.year, _currentDateComponents.month, day]];
        }
        
        [_dateArray addObject:zcalendarModel];
    }
    
    
    [super setNeedsDisplay];
}


- (void)setDate:(NSDate *)date {
    
    _currentDateComponents = [date getDateComponentsByDate];
    _dayCount = [date getDays];
    
    if (_currentDateComponents.month > 9 && _caledarType == CalendarTypeYear) {
        
        _cutOffRule.hidden = YES;
    } else {
        _cutOffRule.hidden = NO;
    }
    
    _interval = [_currentDateComponents weekday] - 1;
    if (_caledarType == CalendarTypeMonth) {
       
        _rowCount = ceil((_dayCount + _interval) / 7);
    } else {
        _rowCount = 6;
    }

    _rowHeight = (self.frame.size.height - self.zcalendarStyle.monthRowHeight) / _rowCount;
    
    [_dateArray removeAllObjects];
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
    
    
    
    CGFloat textHigeht = 0;
    
    for (ZCalendarModel *zcalendarModel in _dateArray) {
        
        if (_zcalendarStyle.dateTextStyle) {
            CGSize size = [zcalendarModel.dateText sizeWithAttributes:_zcalendarStyle.dateTextStyle];
            textHigeht = size.height;
            [self drawText:CGPointMake(zcalendarModel.frame.origin.x + (_columnWidth - size.width) / 2, zcalendarModel.frame.origin.y + _rowHeight - size.height - 4)
                      text:zcalendarModel.dateText fontSize:_zcalendarStyle.dateTextStyle];
        }
        
        if ([self respondsToSelector:@selector(drawRectangle:)]) {
            
            [self drawRectangle:zcalendarModel];
        }
       
    }
    
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
        
        [self drawCutLine:CGPointMake(_interval * _columnWidth, size.height + 5)];
    }
    
    
}

/**
 *  绘制分割线
 */
- (void)drawCutLine:(CGPoint)point {
    CGContextDrawImage(self.context, CGRectMake(point.x, point.y, self.frame.size.width, 2), _zcalendarStyle.cutLineImage.CGImage);
}


/**
 *  获取绘制文字样子
 *
 *  @return NSDictionary 文字样式
 */
//- (NSDictionary *)fontStyle:(CGFloat)fontSize textColor:(UIColor *)textColor {
//    NSDictionary *fontDict = @{
//                               NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
//                               NSForegroundColorAttributeName: textColor
//                               };
//    
//    return fontDict;
//}

- (void)drawText:(CGPoint)point text:(NSString *)text fontSize:(NSDictionary *)fontStyle
{
    // 兼容不同长度的字符串
    [text drawAtPoint:point withAttributes:fontStyle];
}



/**
 *  根据坐标获取日期
 *
 *  @param point
 */
- (ZCalendarModel *)getDateByPoint:(CGPoint)point {
    for (ZCalendarModel *zcalendarModel in _dateArray) {
        if (CGRectContainsPoint(zcalendarModel.frame,point)) {
            
            return zcalendarModel;
            break;
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    ZCalendarModel *zcalendarModel =[self getDateByPoint:[[touches anyObject] locationInView:self]];
    if (zcalendarModel) {
        // 发送点击通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kZCalendarCellViewClick object:zcalendarModel];
    }
    
}
@end
