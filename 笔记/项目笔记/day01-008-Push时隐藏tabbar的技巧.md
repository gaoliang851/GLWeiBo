# Push时隐藏tabbar的技巧

1. 通过设置`UIViewController`属性`hidesBottomBarWhenPushed = true`可以让该ViewController在PUSH时，自动隐藏底部tabbar

   ```swift
   viewController.hidesBottomBarWhenPushed = true
   ```

2. 但是如果每次PUSH时都这样很麻烦，也很容易忘：

   ```swift
   let vc = GLDemoViewController()
   vc.hidesBottomBarWhenPushed = true
   navigationController?.pushViewController(vc, animated: true)
   ```

3. 为了简便性，可以重写`NavigationController`的`pushViewController`方法

   ```swift
   class GLNavigationController: UINavigationController {
       override func pushViewController(_ viewController: UIViewController, animated: Bool) {
           viewController.hidesBottomBarWhenPushed = true
           super.pushViewController(viewController, animated: animated)
       }
   }
   ```

4. 但是这样会有一个问题：在创建`NavigationController`的时候，也会调用这方法：

   ```swift
   let vc = CustomViewController()
   let navgationController = GLNavigationController(rootViewController: vc)
   ```

   这是因为`NavigationController`是以栈的方式来管理子控制器的，创建的时候rootViewController也会压入栈。这就会导致栈底ViewController Push到其他页面再返回栈底ViewController时，tabbar会隐藏。所以设置`hidesBottomBarWhenPushed = true`时，要排除栈底ViewController:

   ```swift
   class GLNavigationController: UINavigationController {
       override func pushViewController(_ viewController: UIViewController, animated: Bool) {
           ////栈底ViewController不设置hidesBottomBarWhenPushed
           if children.count > 0 {
               viewController.hidesBottomBarWhenPushed = true
           }
           super.pushViewController(viewController, animated: animated)
       }
   }
   ```

   

