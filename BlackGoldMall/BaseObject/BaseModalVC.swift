//
//  BaseModalVC.swift
//  Wenyishou
//
//  Created by 永芯 on 2020/6/7.
//  Copyright © 2020 永芯. All rights reserved.
//

import UIKit

class BaseModalVC: BaseViewController {

    let topView = UIView()

    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = defaultTextColor
        label.font = .systemFont(ofSize: 19)
        return label
    }()

    var aniamtion: HSCoverVerticalTransition?

    var dismissBlock : (()->Void)?
    
    init() {
        super.init(nibName:nil, bundle:nil)
        self.aniamtion = HSCoverVerticalTransition.init(present: self, dismiss: true)
        self.transitioningDelegate = self.aniamtion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addRounded(radius: 6, corners: [.topLeft,.topRight])
        view.addSubview(topView)
        let closeBtn = UIButton.init(setImage: "小x_black") {
            self.dismiss(animated: true, completion: nil)
        }
        topView.backgroundColor = .white
        topView.addSubview(closeBtn)
        topView.addSubview(titleLabel)
        
        topView.snp.makeConstraints { (m) in
            m.top.left.right.equalToSuperview()
            m.height.equalTo(65)
        }
        
        closeBtn.snp.makeConstraints { (m) in
            m.top.left.equalTo(15)
            m.bottom.equalTo(-15)
            m.width.equalTo(35)
        }
        titleLabel.snp.makeConstraints { (m) in
            m.center.equalTo(topView.snp.center)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if dismissBlock != nil {
            self.dismissBlock!()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.aniamtion = nil
//        self.transitioningDelegate = nil
//
//    }
}
