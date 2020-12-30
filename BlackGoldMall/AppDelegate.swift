//
//  AppDelegate.swift
//  XinLinProduct
//
//  Created by 永芯 on 2020/8/1.
//  Copyright © 2020 永芯. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AdvertisementView
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
   
    var tabbarController :BaseTabBarController?
    //后台任务
    var backgroundTask:UIBackgroundTaskIdentifier! = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
       
        getHomeImg()
        
        let keyboard = IQKeyboardManager.shared
        keyboard.enable = true
        keyboard.shouldResignOnTouchOutside = true
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        setFirstTabbar()
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func setFirstTabbar()  {
        if UserManager.getUserModel() != nil{
           self.tabbarController = BaseTabBarController.init()
           window?.rootViewController = self.tabbarController
       }else{
           let nav = BaseNavigationController.init(rootViewController: LoginInVController.init())
           window?.rootViewController = nav
       }
    }
    
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
        Unitilty.AboutIsMaxVersion()
        
        if tabbarController != nil {
            if (tabbarController?.viewControllers!.count)! > 3 {
                let nav = (tabbarController?.viewControllers![2])! as! BaseNavigationController
                for vc in nav.viewControllers {
                    if vc.isKind(of: SuanLiViewController.self) {
                        let lsvc :SuanLiViewController = vc as! SuanLiViewController
                        lsvc.djs()
                    }
                }
            }
        }
        
        
    }
    
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }


    
    func getHomeImg()  {
        advertisementView()
        NetworkManager<BaseModel>().requestModel(API.getAdvertisingImg, completion: { (response) in
            if let array = response?.dataArr{
                let slideshowList : Array<Dictionary<String, Any>> = array as! Array<Dictionary<String, Any>>
                
                if slideshowList.count > 0{
                    let dic = slideshowList[0]
                    let imgUrl = dic["imgUrl"] as! String
                    UserDefaults.standard.set(imgUrl, forKey: "AdvertisingImg")
                    
                }else{
                    UserDefaults.standard.set("", forKey: "AdvertisingImg")
                }
            
            }
           }) { (error) in
           
               if let msg = error.message {
                   MBProgressHUD.showText(msg)
               }
           }
       }
    
    func advertisementView()  {
        
        let img = self.getAdvertisingImg()
        if img.length == 0 {
            return
        }
        // 网络资源
        let _ = AdvertisementView(adUrl: img, isIgnoreCache: false, placeholderImage: UIImage.init(named: "qgy"), completion: { (isGotoDetailView) in
            print(isGotoDetailView)
        })
    }
    
    
    func getAdvertisingImg() -> String{
        
        let adImageJPGUrl = UserDefaults.standard.string(forKey: "AdvertisingImg")
        //判断UserDefaults中是否已经存在
        if(adImageJPGUrl != nil){
            return adImageJPGUrl!
        }else{
            //不存在则生成一个新的并保存
            UserDefaults.standard.set("", forKey: "AdvertisingImg")
            return ""
        }
    }
}

