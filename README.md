# water_mark

> A new Flutter package for Watermark. You can use it in page background ,image,document for security。


## How to use?

```dart
//pubspec.yaml add 

water_mark: ^0.0.3

var mark = WaterMark();

mark
.setMarkText('Mark')
.show(context);

//更多使用，查看Example

```

## Screenshot

![image](http://storage.360buyimg.com/dqapptest/water_mark_demo.png)

## Attention
````dart
// 现在是需要传入水印的个数，才能绘制。
// 如果有需要动态计算水印个数，可以通过屏幕宽高，以及单个水印Widget的宽高，
// 以及水印间距，算出需要展示水印个数,然后动态展示，
// 别忘了把Widget换成有状态的动态刷新
// 具体查看源码注释

````

 
