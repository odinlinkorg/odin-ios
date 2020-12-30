//
//  UITableViewExtension.swift
//  GMG
//
//  Created by 永芯 on 2019/12/21.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit

private let emptyViewTag: Int = 350132706

import SnapKit

class EmptyView: UIView {

    /// 空数据提示文字
    lazy var emptyLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.textColor = UIColor(hex: 0xBEBEBE)
        label.font = .systemFont(ofSize: 15)
        label.text = Localized("暂无数据")
        return label
    }()
    
    /// 空数据提示图
    lazy var emptyImageView: UIImageView = {
        let iv = UIImageView.init()
        iv.image = UIImage.init(named: "emptyImg")
        iv.contentMode = .bottom
        return iv
    }()
    
    enum ShowType {
        case image
        case text
    }
    
    var showType:ShowType = .image {
        didSet {
            if showType == .image {
                emptyLabel.isHidden = false
                emptyImageView.isHidden = false
            }else{
                emptyLabel.isHidden = false
                emptyImageView.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emptyImageView)
        addSubview(emptyLabel)
        
        emptyImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().multipliedBy(0.80)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.26)
        }
        emptyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.emptyImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
//        showType = .image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UITableView {
    
    /// 显示空数据提示图
    func showEmtpyImageView(dataCount:Int) {
        showEmtpyImageView(dataCount: dataCount, imageName: "emptyImg")
    }
    
    func showEmtpyImageView(dataCount:Int, imageName:String) {
        if dataCount == 0 {
            if let emView = self.viewWithTag(emptyViewTag) {
                self.addSubview(emView)
                emView.snp.updateConstraints { (make) in
//                    make.top.left.bottom.right.equalTo(0)
                    make.center.equalToSuperview()
                    make.size.equalToSuperview()

                }
                return
            }
            let ev = self.configEmptyView(imageName: imageName, text: Localized("暂无数据"))
            ev.showType = .image
            self.addSubview(ev)
            ev.snp.makeConstraints { (make) in
//                make.top.left.bottom.right.equalTo(0)
                make.center.equalToSuperview()
                make.size.equalToSuperview()
            }
            
        }else{
            if let emView = self.viewWithTag(emptyViewTag) {
                emView.removeFromSuperview()
            }
        }
        configMjFooter(dataCount:dataCount)
    }

    
    
    /// 显示空数据提示文字：暂无数据
    /// - Parameters:
    ///   - offset: 垂直偏移  默认为 1 （0～2）
    func showEmtpyTextView(dataCount:Int) {
        showEmtpyTextView(dataCount: dataCount, text: Localized("暂无数据"))
    }
    func showEmtpyTextView(dataCount:Int, text:String?) {
        if dataCount == 0 {
            if let emView = self.viewWithTag(emptyViewTag) {
                self.addSubview(emView)
                emView.snp.updateConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview().offset(-20)
                }
                return
            }

            let ev = self.configEmptyView(imageName: "", text: text)
            ev.showType = .text
            self.addSubview(ev)
            ev.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
            }
        }else{
           if let emView = self.viewWithTag(emptyViewTag) {
               emView.removeFromSuperview()
           }
        }
        configMjFooter(dataCount:dataCount)
    }
    
    func configMjFooter(dataCount:Int) {
 
//        if dataCount == 0 {
//            self.mj_footer?.isHidden = true
//        } else {
//            self.mj_footer?.isHidden = false
//        }
//        if dataCount%10 == 0  {
//            self.mj_footer?.resetNoMoreData()
//        } else {
//            self.mj_footer?.endRefreshingWithNoMoreData()
//        }
    }
    
    func configEmptyView(imageName:String, text:String?) -> EmptyView {
//        if let emView = self.viewWithTag(emptyViewTag) {
//            return emView as! EmptyView
//        }
//        let emptyView = EmptyView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height-20))
        let emptyView = EmptyView.init()
        emptyView.tag = emptyViewTag
        emptyView.emptyImageView.image = UIImage.init(named: imageName)
        emptyView.emptyLabel.text = text
        return emptyView
    }


}

