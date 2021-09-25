# 自定义控件重写initWithFrame后initWithCoder的细节处理

所有UIView及其子类在开发时，一旦重写了构造函数，必须要实现 initWithCoder函数，以保证提供两个通道(纯代码和XIB)

```swift
class DemoLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI () {
        NSLog("测试项目")
    }

}
```



