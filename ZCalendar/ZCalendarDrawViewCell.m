//
//  ZCalendarDrawView.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarDrawViewCell.h"

@implementation ZCalendarDrawViewCell {
    CGContextRef _context;
    CGFloat dayCount;
    CGFloat rowCount;
    int _month;
    int _year;
    CGFloat _columnWidth;
    CGFloat _rowHeight;
    int interval;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _columnWidth = self.frame.size.width / 7;
        return self;
    }
    return self;
}

- (void)setDate:(int)year month:(int)month
{
    _year = year;
    _month = month;
    if (_month == 2) {
        if ((_year % 4 == 0 && _year % 100 != 0) || _year % 400 == 0){
            dayCount = 29.0;
        } else {
            dayCount = 28.0;
        }
    } else if (_month == 1 || _month == 3 || _month == 5 || _month == 7 || _month == 8 ||_month == 10 || _month == 12) {
        dayCount = 31.0;
    } else {
        dayCount = 30.0;
    }
    interval = 3;
    rowCount = ceil((dayCount + interval) / 7) + 2;
    _rowHeight = self.frame.size.height / (rowCount - 1);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    _context = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(_context, [UIColor whiteColor].CGColor);
    
    
    
    for (int i = 1; i < rowCount; i++) {
        
        CGFloat intervalWidth = 0;
        if (i == 1) {
            intervalWidth = interval * _columnWidth;
        }
        
        CGContextMoveToPoint(_context, intervalWidth, _rowHeight * i);
        CGContextAddLineToPoint(_context, self.frame.size.width, _rowHeight * i);
        CGContextStrokePath(_context);
    }
    
    for (int i = 0; i< (dayCount + interval); i++) {
     
        NSString *text = [NSString stringWithFormat:@"%d",i + 1 - interval];
        CGSize size = [text sizeWithAttributes:[self fontStyle]];
        
        if (i < interval)
        {
            text = @"";
        }
        [self drawText:CGPointMake(_columnWidth * fmod(i , 7) + (_columnWidth - size.width) / 2, _rowHeight + _rowHeight * ceil(i / 7) + _rowHeight/2) text:text];
    }
    
    NSString *text = [NSString stringWithFormat:@"%d月", _month];
    CGSize size = [text sizeWithAttributes:[self fontStyle]];
    [self drawText:CGPointMake(interval * _columnWidth + (_columnWidth - size.width) /2, _rowHeight / 2) text:@"4月"];
    
//    20150415
    NSLog(@"print date is %f",rowCount);
}


/**
 *  获取绘制文字样子
 *
 *  @return NSDictionary 文字样式
 */
- (NSDictionary *)fontStyle {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init]; // 段落样式
    style.alignment = NSTextAlignmentRight;
    NSDictionary *fontDict = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:16],
                               NSForegroundColorAttributeName: [UIColor redColor],
                               NSParagraphStyleAttributeName: style
                               };
    
    return fontDict;
}

- (void)drawText:(CGPoint)point text:(NSString *)text
{
    // 兼容不同长度的字符串
    [text drawAtPoint:point withAttributes:[self fontStyle]];
}
@end
