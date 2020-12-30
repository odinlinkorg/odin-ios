//
//  BaseTabBarController.swift
//  MySwiftDemo
//
//  Created by 永芯 on 2019/12/4.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController,UITabBarControllerDelegate {

    var indexInt : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

    
        let tabbar = UITabBar.appearance()
        tabbar.barTintColor = tabbarBackgroundColor
        tabbar.tintColor = baseTabTextColor
        tabbar.unselectedItemTintColor =  baseNoTextColor
        /// 添加子控制器
        addChildViewControllers()
        self.delegate = self
        
    }
        
    /// 添加子控制器
    private func addChildViewControllers() {
                
        let titleArr = ["首页","商城","算力池","我的"]
        let vcArr = [HomeViewController.init(),MallViewController.init(),SuanLiViewController.init(),MineViewController.init()]
        var i = 0
        for item in titleArr{
             setUpOneChildViewController(vc: vcArr[i], image: "tab\(item)_nomal", selectedImage: "tab\(item)", title: item)
            i = i + 1
        }
    }
    
    func setUpOneChildViewController(vc:UIViewController, image:String, selectedImage:String, title:String) {
        vc.tabBarItem.title = title
        let img = UIImage.init(named: image)!.withRenderingMode(.alwaysOriginal)
        let simg = UIImage.init(named: selectedImage)!.withRenderingMode(.alwaysOriginal)
        
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        vc.tabBarItem.imageInsets=UIEdgeInsets(top: -1,left: 0,bottom: 1,right: 0)
        
        vc.tabBarItem.image = img
        vc.tabBarItem.selectedImage = simg
        let navVC = BaseNavigationController.init(rootViewController: vc)
        vc.title = title;
        addChild(navVC)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.firstIndex(of: item) ?? 0
       
        indexInt = index
  
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
           
           let model = UserManager.getUserModel()
           if indexInt != 0 && model == nil{

               let vc = BaseNavigationController.init(rootViewController: LoginInVController.init())

               keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
                return false
           }
        return true
           
    }

      
    
    
    
      
}


