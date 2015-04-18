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
@implementation ZCalendarDrawViewCell {
    CGContextRef _context;
    CGFloat dayCount;
    CGFloat rowCount;
    
    CGFloat _columnWidth;
    CGFloat _rowHeight;
    NSInteger interval;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _columnWidth = self.frame.size.width / 7;
        _dateArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        return self;
    }
    return self;
}


- (void)setNeedsDisplay {
    
    [_dateArray removeAllObjects];
    
    NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
    CGSize rectangleSize = CGSizeMake(_columnWidth * 0.9, _rowHeight * 0.9);
    for (int i = 0; i< (dayCount + interval); i++) {
        
        if (i < interval) {
            continue;
        }
        CGFloat x = _columnWidth * fmod(i , 7);
        CGFloat y = _rowHeight + _rowHeight * ceil(i / 7);
        
        ZCalendarModel *zcalendarModel = [[ZCalendarModel alloc] init];
        zcalendarModel.frame = CGRectMake(x + (_columnWidth - rectangleSize.width) / 2,
                                          y + (_rowHeight - rectangleSize.height) / 2,
                                          rectangleSize.width,
                                          rectangleSize.height);
        
        NSInteger day = i + 1 - interval;
        
        // 如果是今天,则换个颜色
        if ([_currentDateComponents year] == [today year]
            && [_currentDateComponents month] == [today month]
            && day == [today day]) {
            zcalendarModel.rectangleColor = [UIColor redColor];
        } else {
            zcalendarModel.rectangleColor = [UIColor blueColor];
        }
        
        
        
        zcalendarModel.dateComponents = [[[NSString stringWithFormat:@"%ld-%ld-%ld",
                                           [_currentDateComponents year],
                                           [_currentDateComponents month],
                                           day]
                                          dateFromString]
                                         getDateComponentsByDate];
        
        zcalendarModel.dateText = [NSString stringWithFormat:@"%ld",i + 1 - interval];
        
        [_dateArray addObject:zcalendarModel];
    }

    [super setNeedsDisplay];
}


- (void)setDate:(NSDate *)date {
    
    _currentDateComponents = [date getDateComponentsByDate];
    dayCount = [date getDays];
    
    interval = [_currentDateComponents weekday] - 1;
    rowCount = ceil((dayCount + interval) / 7) + 1;
    _rowHeight = self.frame.size.height / rowCount;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    _context = UIGraphicsGetCurrentContext();
    
    if (_lineColor) {
        CGContextSetStrokeColorWithColor(_context, _lineColor.CGColor);
        
        // 月视图才显示横线
        if (_caledarType == CalendarTypeMonth) {
            for (int i = 1; i < 2; i++) {

                CGFloat intervalWidth = 0;
                if (i == 1) {
                    intervalWidth = interval * _columnWidth;
                }

                CGContextMoveToPoint(_context, intervalWidth, _rowHeight * i);
                CGContextAddLineToPoint(_context, self.frame.size.width, _rowHeight * i);
                CGContextStrokePath(_context);
            }
        }
    }
    // 矩形尺寸
    for (ZCalendarModel *zcalendarModel in _dateArray) {
        
        [zcalendarModel.rectangleColor setFill];
        [self drawRectangle:zcalendarModel.frame lineWidth:0.0];
        
        [self drawText:CGPointMake(zcalendarModel.frame.origin.x, zcalendarModel.frame.origin.y)
                  text:zcalendarModel.dateText
              fontSize:10.0
             textColor:_dateTextColor];
    }
    
    NSString *text = [NSString stringWithFormat:@"%ld月", [_currentDateComponents month]];
    CGSize size = [text sizeWithAttributes:[self fontStyle:16. textColor:[UIColor blackColor]]];
    CGFloat drawMonthX = 0;
    if (_caledarType == CalendarTypeMonth) {
        drawMonthX = interval * _columnWidth + (_columnWidth - size.width) /2;
    }
    [self drawText:CGPointMake(drawMonthX, (_rowHeight - size.height) / 2)
              text:text fontSize:16.0 textColor:[UIColor blackColor]];
}


/**
 *  获取绘制文字样子
 *
 *  @return NSDictionary 文字样式
 */
- (NSDictionary *)fontStyle:(CGFloat)fontSize textColor:(UIColor *)textColor {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init]; // 段落样式
    style.alignment = NSTextAlignmentRight;
    NSDictionary *fontDict = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                               NSForegroundColorAttributeName: textColor,
                               NSParagraphStyleAttributeName: style
                               };
    
    return fontDict;
}

- (void)drawText:(CGPoint)point text:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    // 兼容不同长度的字符串
    [text drawAtPoint:point withAttributes:[self fontStyle:fontSize textColor:textColor]];
}

/**
 *  绘制矩形
 *
 *  @param rect 矩形尺寸
 */
- (void)drawRectangle:(CGRect)rect lineWidth:(CGFloat)lineWidth{
    
    UIColor *aColor = [UIColor whiteColor];
    CGContextSetStrokeColorWithColor(_context, aColor.CGColor);//线框颜色
    CGContextSetLineWidth(_context, lineWidth);
    
    CGMutablePathRef pathRef = [self pathwithFrame:rect withRadius:0];
    
    CGContextAddPath(_context, pathRef);
    CGContextDrawPath(_context,kCGPathFillStroke);
    
    CGPathRelease(pathRef);
}

/**
 *  生成矩形路径
 *
 *  @param frame  矩形尺寸
 *  @param radius 圆角弧度
 *
 *  @return CGMutablePathRef 矩形路径
 */
- (CGMutablePathRef)pathwithFrame:(CGRect)frame withRadius:(float)radius
{
    CGPoint x1, x2, x3, x4; //x为4个顶点
    CGPoint y1, y2, y3, y4, y5, y6, y7, y8; //y为4个控制点
    //从左上角顶点开始，顺时针旋转,x1->y1->y2->x2
    
    x1 = frame.origin;
    x2 = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    x3 = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height);
    x4 = CGPointMake(frame.origin.x, frame.origin.y + frame.size.height);
    
    
    y1 = CGPointMake(frame.origin.x + radius, frame.origin.y);
    y2 = CGPointMake(frame.origin.x + frame.size.width - radius, frame.origin.y);
    y3 = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y + radius);
    y4 = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height - radius);
    
    y5 = CGPointMake(frame.origin.x + frame.size.width-radius, frame.origin.y+frame.size.height);
    y6 = CGPointMake(frame.origin.x + radius, frame.origin.y + frame.size.height);
    y7 = CGPointMake(frame.origin.x, frame.origin.y + frame.size.height-radius);
    y8 = CGPointMake(frame.origin.x, frame.origin.y + radius);
    
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    if (radius <= 0) {
        CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, x1.x, x1.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x2.x, x2.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x3.x, x3.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x4.x, x4.y);
    } else {
        CGPathMoveToPoint(pathRef,    &CGAffineTransformIdentity, y1.x, y1.y);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y2.x, y2.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x2.x, x2.y, y3.x, y3.y, radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y4.x, y4.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x3.x, x3.y, y5.x, y5.y, radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y6.x, y6.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x4.x, x4.y, y7.x, y7.y, radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y8.x, y8.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x1.x, x1.y, y1.x, y1.y, radius);
    }
    CGPathCloseSubpath(pathRef);
    return pathRef;
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
