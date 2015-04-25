//
//  UICollectionViewCell+AirQuality.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/23.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarDrawViewCell+Custom.h"

@implementation ZCalendarDrawViewCell (Custom)

- (void)drawRectangleByYear:(ZCalendarModel *)zCalendarmodel {
    
    NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
    CGFloat linWidth = 0;
    if (zCalendarmodel.dateComponents.year == today.year
        && zCalendarmodel.dateComponents.month == today.month
        && zCalendarmodel.dateComponents.day == today.day) {
        linWidth = 1.0;
    } else {
        linWidth = 0.0;
    }

    if (self.dataArray) {
        
        NSString *dateText = [zCalendarmodel.date dateTostring];
        
        if ([self.dataArray objectForKey:dateText]) {
            zCalendarmodel.rectangleColor = [UIColor blackColor];
        } else {
            zCalendarmodel.rectangleColor = self.zcalendarStyle.normalDateColoe;
        }
    }
    [zCalendarmodel.rectangleColor setFill];
    [self drawCustom:zCalendarmodel.frame lineWidth:linWidth];
}

- (void)drawRectangleByMonth:(ZCalendarModel *)zCalendarmodel {
    
    NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
    CGFloat linWidth = 0;
    if (zCalendarmodel.dateComponents.year == today.year
       && zCalendarmodel.dateComponents.month == today.month
       && zCalendarmodel.dateComponents.day == today.day) {
        linWidth = 1.0;
    } else {
        linWidth = 0.0;
    }
    CGRect frame = zCalendarmodel.frame;
    frame.size.height = self.rowHeight / 2;
    
    NSString *strings;
    if (self.dataArray) {
        
        NSString *dateText = [zCalendarmodel.date dateTostring];
        
        if ([self.dataArray objectForKey:dateText]) {
            zCalendarmodel.rectangleColor = [UIColor blackColor];
            strings = [NSString stringWithFormat:@"%@", [[self.dataArray objectForKey:dateText] objectForKey:@"aqi"]];
        } else {
            zCalendarmodel.rectangleColor = self.zcalendarStyle.normalDateColoe;
        }
    }
    [zCalendarmodel.rectangleColor setFill];
    [self drawCustom:frame lineWidth:linWidth];
    
    // 设置日期文字颜色
    NSDictionary *textStyle = @{
                                NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                NSForegroundColorAttributeName: [UIColor whiteColor]
                                };
    
    if (strings) {
        CGSize size = [strings sizeWithAttributes:textStyle];
        [self drawText:CGPointMake((frame.origin.x + (self.columnWidth - size.width) / 2), frame.origin.y + (frame.size.height - size.height) / 2) text:strings fontSize:textStyle];
    }
}

- (void)drawRectangleByWeek:(ZCalendarModel *)zCalendarmodel {
    
    NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
    
    // 如果是今天,则换个颜色
    CGRect frame = zCalendarmodel.frame;
    if (zCalendarmodel.dateComponents.year == today.year
        && zCalendarmodel.dateComponents.month == today.month
        && zCalendarmodel.dateComponents.day == today.day) {
        
        frame.size.height = self.rowHeight / 2;
        frame.origin.y = self.rowHeight / 2;
        
    } else {
        
        frame.size.height = 4.5;
        frame.origin.y = frame.origin.y + self.rowHeight;
        
    }
    
    CGFloat textY = zCalendarmodel.frame.origin.y + self.rowHeight / 2;
    CGFloat rectangleHeight = self.rowHeight / 2;
    
    NSString *strings;
    if (self.dataArray) {
        
        NSString *dateText = [zCalendarmodel.date dateTostring];
        
        if ([self.dataArray objectForKey:dateText]) {
            zCalendarmodel.rectangleColor = [UIColor blackColor];
            strings = [NSString stringWithFormat:@"%@", [[self.dataArray objectForKey:dateText] objectForKey:@"aqi"]];
        } else {
            zCalendarmodel.rectangleColor = self.zcalendarStyle.normalDateColoe;
        }
    }
    
    [zCalendarmodel.rectangleColor setFill];
    [self drawCustom:frame lineWidth:0.0];
    
    // 设置日期文字颜色
    NSDictionary *textStyle = @{
                                NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                NSForegroundColorAttributeName: [UIColor whiteColor]
                                };
    
    if (strings) {
        CGSize size = [strings sizeWithAttributes:textStyle];
        [self drawText:CGPointMake((zCalendarmodel.frame.origin.x + (self.columnWidth - size.width) / 2), textY + (rectangleHeight - size.height) / 2) text:strings fontSize:textStyle];
    }
    
}

- (void)drawRectangle:(ZCalendarModel *)zCalendarmodel {
 
    if (self.caledarType == CalendarTypeWeek) {
        
        [self drawRectangleByWeek:zCalendarmodel];
        
    } else if (self.caledarType == CalendarTypeMonth){
        
        [self drawRectangleByMonth:zCalendarmodel];
    } else {
        [self drawRectangleByYear:zCalendarmodel];
    }
    
    //    }
    
    //    [self drawCustom:frame lineWidth:lineWidth];
    
    
    
    
    
}

/**
 *  绘制矩形
 *
 *  @param rect 矩形尺寸
 */
- (void)drawCustom:(CGRect)rect lineWidth:(CGFloat)lineWidth {
    
    UIColor *aColor = [UIColor whiteColor];
    CGContextSetStrokeColorWithColor(self.context, aColor.CGColor);//线框颜色
    CGContextSetLineWidth(self.context, lineWidth);
    
    CGMutablePathRef pathRef = [self pathwithFrame:rect withRadius:0];
    
    CGContextAddPath(self.context, pathRef);
    CGContextDrawPath(self.context,kCGPathFillStroke);
    
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


@end
