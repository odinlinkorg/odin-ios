//
//  InvitationController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import LLCycleScrollView

class InvitationController: BaseViewController {

    var inviteUrl: String = ""
    var bannerView: LLCycleScrollView!
    var imagePaths : NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "邀请好友"
        addRightNavItem("邀请记录")

        //轮播图
        bannerView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0 , y: 0, width: kScreenWidth, height:  kScreenHeight - 51.0 - kNavBarHeight  - kTabBarHeight))
        bannerView.delegate = self
        // 是否自动滚动
        bannerView.autoScroll = false
        bannerView.imageViewContentMode = .scaleToFill
        // 如果没有数据的时候，使用的封面图
        bannerView.coverImage = UIImage.init(named: "mine_yaoqing_one")
        bannerView.backgroundColor = .clear
        view.addSubview(bannerView)
        
        
        let ercode = UIImageView.init(frame: CGRect.init(x: (screenWidth - 110)/2, y: screenHeight - 320 , width: 110, height: 110))
        ercode.backgroundColor = .white
        ercode.image = UIImage.setupQRCodeImage(String.init(format:"invitecode=%@" , (UserManager.getUserModel()?.inviteCode)!), size: ercode.size.width)
        view.addSubview(ercode)
        
        let buttonGZ = UIButton.init(frame: CGRect.init(x: kScreenWidth - 66.5, y: ercode.bottom - 33.0, width: 80.5, height: 33.0))
        buttonGZ.setImage(UIImage.init(named: "mine_jiangliguize"), for: .normal)
        buttonGZ.addTarget(self, action: #selector(guizeAction), for: .touchUpInside)
        view.addSubview(buttonGZ)
        
        

        
       
        
        
        NetworkManager<BaseModel>().requestModel(API.shopCommonGetInviteUrl, completion: { (response) in
            if let data = response?.dataDict{
                self.inviteUrl = (data["InviteUrl"] as! String)   + (UserManager.getUserModel()?.inviteCode)!
            }
               }) { (error) in
                   if let msg = error.message {
                       MBProgressHUD.showText(msg)
                   }
               }
    }
    
    @objc func guizeAction(){
        navigationController?.pushViewController(InviteRulesVController.init(), animated: true)
    }
    
    override func clickRightItem() {
        navigationController?.pushViewController(InvitedRecordViewController.init(), animated: true)
    }
    
     func shaHaiBao() {
        
        bannerView.pageControl?.isHidden = true
        let image = bannerView.getImageFromView()
             bannerView.pageControl?.isHidden = false
        
        let v = UIView.init(frame: bannerView.frame)
        let imgV = UIImageView.init(frame: bannerView.frame)
        imgV.image = image
        
        
        let ercode = UIImageView.init(frame: CGRect.init(x: (screenWidth - 110)/2, y: screenHeight - 320 , width: 110, height: 110))
               ercode.backgroundColor = .white
        ercode.image = UIImage.setupQRCodeImage(String.init(format:"invitecode=%@" , (UserManager.getUserModel()?.inviteCode)!), size: ercode.size.width)
        v.addSubview(imgV)
        v.addSubview(ercode)
         let imageNew = v.getImageFromView()
        let activityVC = UIActivityViewController(activityItems: [imageNew], applicationActivities: nil)
             present(activityVC, animated: true, completion: nil)
      
    }

    
    
    @IBAction func linkButtonAction(_ sender: Any) {
    
        if self.inviteUrl.length != 0 {
            
            let pastboard = UIPasteboard.general
            pastboard.string = inviteUrl
            MBProgressHUD.showText("复制成功")
        }
        
       
    }
    
    @IBAction func codeButtonAction(_ sender: Any) {
        
        if let model = UserManager.getUserModel(){
                  
          let pastboard = UIPasteboard.general
          pastboard.string = model.inviteCode
          MBProgressHUD.showText("复制成功")
      }
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        shaHaiBao()
    }
}

extension InvitationController: LLCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: LLCycleScrollView, didSelectItemIndex index: NSInteger) {
        
       
    }
    
   
}


