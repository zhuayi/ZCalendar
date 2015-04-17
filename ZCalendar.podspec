Pod::Spec.new do |s|
  s.name             = "ZCalendar"
  s.version          = "0.0.1"
  s.summary          = "使用的drawRect绘制的高效日历类"
  s.description      = <<-DESC
                       充分利用 UICollectionView 的复用机制, 在 年,月视图下将一个月就是一个 view, 通过 view 的drawRect方法将日期绘制在 view 里. 这样1年也就12个 view,10年也就才120个view, 在加上UICollectionView对 cellView的复用机制,所以每次展示时只有一个 view,性能会有大大的提升
                       DESC
  s.homepage         = "https://github.com/zhuayi/ZCalendar"
  s.license          = 'MIT'
  s.author           = { "zhuayi" => "2179942@qq.com" }
  s.source           = { :git => "https://github.com/zhuayi/ZCalendar.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :ios, '7.0'
 
  s.requires_arc = true

  s.source_files = 'ZCalendar/ZCalendar/*'
  
  s.frameworks = 'Foundation', 'UIKit'
#s.dependency "AFNetworking", "~> 2.5.0"
end