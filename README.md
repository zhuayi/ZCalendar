
# 日历

### 其他第三方库缺点

> 目前网上开源的第三方库都是在UICollectionView基础上开发的,每一个日期都是一个 cellView, 1年365天久是365个view, 虽然UICollectionView有复用机制,但一个视图下显示30个 View, 在性能要求极端的情况无疑不是一个好的方法. 

> 但是天眼日历需要在一个复杂的页面显示日历, view 太多会造成性能问题, 所以需要一个性能更好地日历库.

### 如何提高性能

> 充分利用 UICollectionView 的复用机制, 在 **年**,**月**视图下将一个月就是一个 view, 通过 view 的drawRect方法将日期绘制在 view 里. 

> 这样1年也就12个 view,10年也就才120个view, 在加上UICollectionView对 cellView的复用机制,所以每次展示时只有一个 view,性能会有大大的提升

### 难点

- 日历算法, 闰月, 瑞年

- 每个月的日期数不同,每个月1号是周几是不同的

- 每一个日期在一个 view 中的坐标

- 如何获取点击的是哪个日期

### 前期准备

- NSDate 扩展类

- 获取当前日期的*年* *月* *周*

- 获取一个月有多少天

- NSString 扩展类

- 根据时间戳返回时间

- drawRect 绘制类

- 绘制文字

- 绘制矩形

- ZCalendarModel 日期对象

- 日期尺寸: ```CGRect frame```

- 矩形颜色: ```UIColor *rectangleColor```

- 日期文字: ```NSString *dateText```

- ZCalendarStyle 自定义样式类

### 自定义外观

自定义头部 view, 不显示不设置,默认为nil

```objective-c
@property(nonatomic, strong) UIView *header;
```

自定义每个cell的高度

```objective-c
@property(nonatomic, assign) CGSize cellSize;
```

自定义Cell 的间距

```objective-c
@property(nonatomic, assign) UIEdgeInsets cellEdgeInsets;
```

自定义线条颜色

```objective-c
@property(nonatomic, strong) UIColor *lineColor;
```

自定义日期文字颜色

```objective-c
@property(nonatomic, strong) UIColor *dateTextColor;
```

自定义选中的日期背景色

```objective-c
@property(nonatomic, strong) UIColor *selectDateColor;
```

自定义默认日期背景色

```objective-c
@property(nonatomic, strong) UIColor *normalDateColoe;
```

自定义日期区间

```objective-c
- (void)setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData;
```

月份显示的行高

```objective-c
@property(nonatomic, assign) CGFloat monthRowHeight;
```

section高度

```objective-c
@property(nonatomic, assign) CGFloat sectionHeight;
```

每行的间距

```objective-c
@property(nonatomic, assign) CGFloat minimumLineSpacing;
```

### 回调代理

选中日期回调

```objective-c
- (void)didClickDate:(ZCalendarModel *)zcalendarModel
```

从视图左上角开始,当前显示的日期,只包含年/月信息

```objective-c
- (void)didShowLeftTopCell:(ZCalendarDrawViewCell *)zcalendarDrawViewCell
```

#### 绘制日历关键参数

1. 根据日历视图计算每一个 cellView 需要显示多少个日期,一个日期绘制一个矩形

计算月1号是周几

```objective-c
_interval = [dateComponents weekday] - 1;
```

计算这个月总共多少天

```objective-c
_dayCount = [date getDays];
```

一行显示7个日期,计算需要多少行

```objective-c
_rowCount = ceil((dayCount + interval) / 7) + 1;
```

计算每行的高度

```objective-c
_rowHeight = self.frame.size.height / rowCount;
```

2. 计算每个矩形的尺寸和位置

width

```objective-c
_columnWidth = self.frame.size.width / 7;
```
height

```objective-c
_rowHeight = self.frame.size.height / rowCount;
```
X

```objective-c
x = _columnWidth * fmod(i , 7);
```
Y

```objective-c
Y = rowHeight + _rowHeight * ceil(i / 7);
```

### 架构设计

![][image-1]

基类类: ZCalendarView.h 

> ZCalendarView作为入口类,所有需要加载日历的控制器只需要继承该类即可.

管理类: ZCalendarCollectionView.h

> ZCalendarCollectionView 为 cell 管理类,控制 cell 数量, cell 的展示规则

视图类: ZCalendarDrawViewCell.h

> ZCalendarDrawViewCell 为 cell 绘制类,负责绘制 cell(日历).

模型类: ZCalendarModel.h

> ZCalendarModel 为模型类, 有日历矩形的尺寸,位置,颜色,文字等属性

代理类: ZCalendarDelegate.h

> ZCalendarDelegate为代理类, 负责传递日历的点击回调

自定义样式类: ZCalendarStyle.h

> ZCalendarStyle为样式类, 提供多个属性控制视图样式

### Example

MonthCalendarView.h

```objective-c
#import "ZCalendarView.h"
@interface MonthCalendarView : ZCalendarView
@end
```

MonthCalendarView.m

```objective-c
- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.zcalendarStyle.cellSize = CGSizeMake(frame.size.width, 200);
		// 线条颜色
		self.zcalendarStyle.lineColor = [UIColor greenColor];
		// cell边距
		self.zcalendarStyle.cellEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
		NSDateComponents *today = [[NSDate date] getDateComponentsByDate];
		// 设置选中日期颜色
		self.zcalendarStyle.selectDateColor = [UIColor redColor];
		// 设置默认日期颜色
		self.zcalendarStyle.normalDateColoe = [UIColor groupTableViewBackgroundColor];
		// 设置显示的年视图
		self.caledarType = CalendarTypeMonth;
		// 设置日期文字颜色
		self.zcalendarStyle.dateTextColor = [UIColor blackColor];
		// 设置日历显示区间, 要放在最下边
		[self setYearInterval:2010 endDate:[today year]];
		}
	return self;
}
\`\`\`  

![][image-2]

> gitHub地址 : [https://github.com/zhuayi/ZCalendar][1]

[1]:	https://github.com/zhuayi/ZCalendar

[image-1]:	http://ww4.sinaimg.cn/large/687dbab7jw1er8q9ojjupj20vw0cpwfq.jpg "架构图"
[image-2]:	https://raw.githubusercontent.com/zhuayi/ZCalendar/master/screenshot.png