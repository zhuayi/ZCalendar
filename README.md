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
@property(nonatomic, strong) UIColor *normalDateColoe
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


### 架构设计
- 入口类: ```ZCalendarView```
	> ZCalendarView作为入口类,所有需要加载日历的控制器只需要addSubview该类即可.
- 管理类: ```ZCalendarCollectionView```
	> ZCalendarCollectionView 为 cell 管理类,控制 cell 数量, cell 的展示规则
- 视图类: ```ZCalendarDrawViewCell```
	> ZCalendarDrawViewCell 为 cell 绘制类,负责绘制 cell(日历).
- 模型类: ```ZCalendarModel```
	> ZCalendarModel 为模型类, 有日历矩形的尺寸,位置,颜色,文字等属性
- 代理类: ```ZCalendarDelegate```
	> ZCalendarDelegate为代理类, 负责传递日历的点击回调

![][image-1]


### 代码预览&地址
 ![][image-2]

> gitHub地址 : [https://github.com/zhuayi/ZCalendar][1]

[1]:	https://github.com/zhuayi/ZCalendar

[image-1]:	http://ww4.sinaimg.cn/large/687dbab7jw1er8q9ojjupj20vw0cpwfq.jpg "架构图"
[image-2]:	http://ww3.sinaimg.cn/bmiddle/687dbab7jw1er8mjqkltij20hs0vk780.jpg