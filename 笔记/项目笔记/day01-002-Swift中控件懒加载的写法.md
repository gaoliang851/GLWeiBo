# Swift中控件懒加载的写法

视频中采用了可选项的写法。这是Swift3.0中的写法。

```swift
class ViewController: UIViewController {
	var label2: DemoLabel?
  private func setupUI() {
  	label2 = DemoLabel()
    label2?.text = "Hello world"
    label2?.sizeToFit()
    self.view.addSubview(label2!)
  }
}
```

在Swift5.0中有了**lazy**关键字。通常的写法：

```swift
class ViewController: UIViewController {
	private lazy var label = { () -> DemoLabel in
        var label = DemoLabel()
        label.text = "hello world"
        label.sizeToFit()
        return label
  }()
  private func setupUI() {
  	view.addSubView(label3)
  }
}
```

如果指定了label的类型，可以省略后面的`() -> DemoLabel in`，因为系统已经可以推断出label的类型了。

```swift
class ViewController: UIViewController {
	private lazy var label: DemoLabel = {
        var label = DemoLabel()
        label.text = "hello world"
        label.sizeToFit()
        return label
    }()
}
// 或者
class ViewController: UIViewController {
	private lazy var label = DemoLabel()
}
```

lazy var 本质上是声明并执行的闭包，或一个有返回值的函数调用
 **只执行一次**，使用的时候一定不为空
 瞬发闭包（Immdiately-applied closures），它是自动@noescape的。这就意味着在这个闭包中无需加[unowned self]：这里不会产生引用循环。

参考文章：

https://www.jianshu.com/p/790971fc253a

