//
//  ChongBiController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ChongBiController: BaseViewController {

    @IBOutlet weak var erCodeImg: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "充币"
        // Do any additional setup after loading the view.
        walletAddress()
    }
    
    func walletAddress(){
        NetworkManager<BaseModel>().requestModel(API.userWalletAddress, completion: { (response) in
           if let dict = response?.dataDict {
            self.addressLabel.text =  (dict["address"] as! String)
            self.erCodeImg.image = UIImage.setupQRCodeImage(self.addressLabel.text!, size: self.erCodeImg.size.width)
           }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    
    @IBAction func saveImgAction(_ sender: Any) {
        if self.addressLabel.text?.length != 0 {
            Unitilty.photoAlbumPermissions(authorizedBlock: {
                if let img = self.erCodeImg.image {
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
    
    @IBAction func copyAddressAction(_ sender: Any) {
        
        if self.addressLabel.text?.length != 0 {
            let pastboard = UIPasteboard.general
            pastboard.string = addressLabel.text
            MBProgressHUD.showText("复制成功")
               
        }
        
    }
}
