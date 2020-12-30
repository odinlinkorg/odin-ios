//
//  MiddleAlertView.swift
//  Wenyishou
//
//  Created by 永芯 on 2020/5/22.
//  Copyright © 2020 永芯. All rights reserved.
//

import UIKit
import SnapKit

class MiddleAlertView: UIView {

    lazy var bgView: UIView = {
        let bgview = UIView.init(frame: CGRect.zero)
        bgview.backgroundColor = .white
        bgview.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        bgview.radiusBounds = 12
        return bgview
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton.init(setImage: "小x") {
            self.removeAlertView()
        }
        return btn
    }()
    
    //    typealias clickBtnBlock = (()->Void)
    var actionBlock : (()->Void)?
    var closeFinishBlock : (()->Void)?

    init(_ margins: CGFloat, height: CGFloat, action: (()->Void)?) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.backgroundColor = UIColor.init(white: 0, alpha: 0)
        defer {
            self.showAlertView()
        }
        self.actionBlock = action
        self.addSubview(bgView)
        self.bgView.addSubview(self.closeBtn)

        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(margins)
            make.right.equalTo(-margins)
            make.centerY.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(height)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        }
        
//        self.addTapGes {[weak self](_) in
//            self?.removeAlertView()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //显示
    func showAlertView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.bgView.transform  = CGAffineTransform.init(scaleX: 1, y: 1)
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        }) { (finished) in
            
        }
    }
    //隐藏
    func removeAlertView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.bgView.transform  = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
            self.backgroundColor = UIColor.init(white: 0, alpha: 0)
        }) { (finished) in
            self.removeFromSuperview()
            if self.closeFinishBlock != nil {
                self.closeFinishBlock!()
            }
        }
    }

}
