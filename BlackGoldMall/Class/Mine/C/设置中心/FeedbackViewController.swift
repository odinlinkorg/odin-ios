//
//  FeedbackViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class FeedbackViewController: BaseViewController {
 @IBOutlet weak var textView: UITextView!
 @IBOutlet weak var phoneF: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "意见反馈"
//        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func bottomAction(_ sender: Any) {
        if textView.text.length == 0{
            MBProgressHUD.showText("请详细描述您的问题或建议，我们将及时跟进解决")
            return
        }
        if phoneF.text!.length == 0{
            MBProgressHUD.showText("请输入QQ/邮箱/电话，方便我们联系您")
            return
        }
        NetworkManager<BaseModel>().requestModel(API.shopCommonInsertMessageBoard(contactWay: phoneF.text!, messageBoard: textView.text), completion: { (response) in
            MBProgressHUD.showText("意见反馈提交成功")
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
}
