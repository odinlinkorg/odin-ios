//
//  ZhuanZSuccessVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/9/1.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ZhuanZSuccessVController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.dismiss(animated: true, completion: nil)
        }
    }


   

}
