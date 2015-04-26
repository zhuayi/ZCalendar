//
//  UICollectionViewCell+AirQuality.m
//  ZCalendar
//
//  Created by zhuayi on 15/4/23.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZCalendarDrawViewCell+Custom.h"
#import "UIView+ZQuartz.h"
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
    [self drawRectangle:zCalendarmodel.frame lineWidth:linWidth color:[UIColor whiteColor]];
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
    [self drawRectangle:frame lineWidth:linWidth color:[UIColor whiteColor]];
    
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
    [self drawRectangle:frame lineWidth:0.0 color:[UIColor whiteColor]];
    
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

- (void)drawCustom:(ZCalendarModel *)zCalendarmodel {
 
    if (self.caledarType == CalendarTypeWeek) {
        
        [self drawRectangleByWeek:zCalendarmodel];
        
    } else if (self.caledarType == CalendarTypeMonth){
        
        [self drawRectangleByMonth:zCalendarmodel];
    } else {
        [self drawRectangleByYear:zCalendarmodel];
    }
}

@end
