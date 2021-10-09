1. navigationBar.titleTextAttributes 可以设置标题样式

   ```swift
   navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.orange,
                                                                           .font:UIFont.systemFont(ofSize: 24)]
   ```

   ![](imgs/WX20211009-184228.png)

2. barTintColor可以设置navigationBar的背景颜色

   ```swift
   navigationController?.navigationBar.barTintColor = .red
   ```

   ![](imgs/WX20211009-184401.png)

3. tintColor可以设置navigationBar的UIBarButtonItem的文字颜色

   ```swift
   navigationController?.navigationBar.tintColor = .green
   ```

   ![](imgs/WX20211009-184524.png)

