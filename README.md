# 日历
### 第三方库
> 目前网上开源的第三方库都是在UICollectionView基础上开发的,每一个日期都是一个 cellView, 如果一个页面单独显示日历,则这些开源的第三方库都支持. 
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
- 日期model
	- 日期尺寸: ```CGRect frame```
	- 矩形颜色: ```UIColor *rectangleColor```
	- 日期文字: ```NSString *dateText```


### 对外API
> CellView 尺寸 : ```CGSize cellSize```
> CellView边距: ```UIEdgeInsets cellEdgeInsets``` 
> 视图类型,年/月/周 : ```CalendarType caledarType```
> 设置日历区间 : ```setYearInterval:(NSInteger)starDate endDate:(NSInteger)endData```
> 线条颜色: ```UIColor *lineColor```
> 文字颜色: ```UIColor *dateTextColor```


### 回调代理
- 点击日历回调
- 点击CellView 回调


#### 绘制日历
1. 根据日历视图计算每一个 cellView 需要显示多少个日期,一个日期绘制一个矩形
	1. . 计算当月1号是周几 : ```interval = [dateComponents weekday] - 1```
	2. 每一个 cellView 需要显示 N + interval个日期
		1. 年和月视图, 根据*获取一个月有多少天*扩展方法获取View 需要绘制多少个矩形
		2. 周视图7个矩形
	

2. 计算每个矩形的位置
	1. width: ```_columnWidth = self.frame.size.width / 7```
	2. height: ```_rowHeight = self.frame.size.height / 6;```  
	3. X 轴坐标: ```_columnWidth * fmod(i , 7)```
	4. Y 轴坐标: ```_rowHeight + _rowHeight * ceil(i / 7)```


> ```objective-c
>	_currentDateComponents = [date getDateComponentsByDate];	
>	dayCount = [date getDays];
>	interval = [_currentDateComponents weekday] - 1;
>	_month = [_currentDateComponents month];
>	_year = [_currentDateComponents year];
>	rowCount = ceil((dayCount + interval) / 7) + 2;	
>	CGSize rectangleSize = CGSizeMake(_columnWidth * 0.9, _rowHeight * 0.9);
>	for (int i = 0; i< (dayCount + interval); i++) {
>		if (i < interval) {
>			continue;
>		}
>		CGFloat x = _columnWidth * fmod(i , 7);
>		CGFloat y = _rowHeight + _rowHeight * ceil(i / 7);	
>		ZCalendarModel *zcalendarModel = [[ZCalendarModel alloc] init];
>		zcalendarModel.frame = CGRectMake(x + (_columnWidth - rectangleSize.width) / 2,
>										  y + (_rowHeight - rectangleSize.height) / 2,
>										  rectangleSize.width,
>										  rectangleSize.height);
>		zcalendarModel.rectangleColor = [UIColor blueColor];
>		zcalendarModel.dateText = [NSString stringWithFormat:@"%ld",i + 1 - interval];
>		
>		[_dateArray addObject:zcalendarModel];
>	}
> ```
 
> gitHub地址 : [https://github.com/zhuayi/ZCalendar]
