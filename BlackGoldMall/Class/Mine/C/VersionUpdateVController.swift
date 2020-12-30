//
//  VersionUpdateVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class VersionUpdateVController: BaseViewController {
    var updateDescText : String!

    @IBOutlet weak var update_desc: UITextView!
    var downUrl : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        update_desc.text = updateDescText
        // Do any additional setup after loading the view.
    }

    @IBAction func notUpdateButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func updateButtonAction(_ sender: Any) {
        UIApplication.shared.open(URL.init(string: downUrl!)!, options: [:], completionHandler: nil)
    }
}
