//
//  PaymentCodeController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class PaymentCodeController: BaseViewController {

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var iphoneLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的收款码"
        // Do any additional setup after loading the view.
        
        if let userModel = UserManager.getUserModel(){
            let str = dicValueString(["data":userModel.phone!,"type":"1"])
            self.imgV.image = UIImage.setupQRCodeImage(str!, size: self.imgV.size.width)
            iphoneLabel.text = userModel.phone
        }
         
    }

  @IBAction func saveErCodeImageAction(_ sender: Any) {
        if UserManager.getUserModel() != nil {
      
            Unitilty.photoAlbumPermissions(authorizedBlock: {
                if let img = self.imgV.image {
                    UIImageWriteToSavedPhotosAlbum(img, self, #selector(self.save(image:didFinishSavingWithError:contextInfo:)), nil)
                }
            }) {
                DebugLog("没有权限打开相册")
            }
        
        }

        
    }
    
    
    @objc func save(image:UIImage, didFinishSavingWithError:NSError?,contextInfo:AnyObject) {
              
              if didFinishSavingWithError != nil {
                  MBProgressHUD.showText("error")
      //            MBProgressHUD.showText(Localized("保存失败"))
              } else {
                  MBProgressHUD.showText(Localized("保存成功"))
              }
          }
   

    
    func dicValueString(_ dic:[String : Any]) -> String?{
            let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
            let str = String(data: data!, encoding: String.Encoding.utf8)
            return str
        }

}
