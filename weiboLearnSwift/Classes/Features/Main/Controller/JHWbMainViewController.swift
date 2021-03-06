//
//  JHWbMainViewController.swift
//  weiboLearnSwift
//
//  Created by 万家豪 on 2017/8/23.
//  Copyright © 2017年 万家豪. All rights reserved.
//

///warning :tabBarItem 颜色有问题
import UIKit
class JHWbMainViewController: UITabBarController,JHWbMainTabBarDelegate {
    /// MARK: - lazyLoad
    private lazy var mainTabBar = JHWbMainTabBar.init(frame: self.tabBar.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildVc()
        setupTabBar()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        hidesBottomBarWhenPushed = true
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
////        hidesBottomBarWhenPushed = false
//    }
}

// MARK:- setupChildVC
extension JHWbMainViewController {
    //Json创建控制器
    private func setupChildVc() {
        let jsonData = NSData.init(contentsOfFile: Bundle.main.path(forResource: "MainVCSettings.json", ofType:nil)!)
        do {
            let jsonArray: [[String: String]] = (try JSONSerialization.jsonObject(with:jsonData! as Data, options:.mutableContainers) as? [[String: String]])!
            for dict in jsonArray {
                let vcName = dict["vcName"]
                let title = dict["title"]
                let imageName = dict["imageName"]
                addChildViewController(childVcName: vcName!, title: title!, imageName: imageName!)
            }
        } catch {
            print(error)
        }
    }
    
    //添加子控制器
    private func addChildViewController(childVcName: String, title : String, imageName : String) {
        //获取命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        guard let childVcClass = NSClassFromString(nameSpace + "." + childVcName) else  {
            print("没有获取到字符串对应的Class")
            return
        }
        //将对应的AnyObject转成控制器的类型
        let childVcType = childVcClass as? UIViewController.Type
        //创建对应的控制器对象
        let childVc = childVcType!.init()
        childVc.title = title
        childVc.tabBarItem.image = UIImage.init(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage.init(named: imageName + "_selected")
        let childNav = UINavigationController.init(rootViewController: childVc)
        addChildViewController(childNav)
    }
}

// MARK:- setupView
extension JHWbMainViewController {
    private func setupTabBar() {
        UINavigationBar.appearance().tintColor = UIColor.orange
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor :  UIColor.black], for: .selected)
        mainTabBar.mainTabBarDelegate = self
        self.setValue(mainTabBar, forKey: "tabBar")
    }
}

// MARK:- 事件监听
extension JHWbMainViewController {
    @objc private func composeButtonClick() -> Void {
        print("点击了发布按钮")
    }
}

//MARK:- JHWbMainTabBarDelegate
extension JHWbMainViewController {
     func barBtnAction(_ sender: JHWbTabBarAddBtn) {
        let composeVC = JHWbComposeViewController()
        composeVC.modalPresentationStyle = .custom
        present(composeVC, animated: true) {
        }
    }
}
