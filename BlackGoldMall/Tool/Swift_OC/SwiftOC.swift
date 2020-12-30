//
//  SwiftOC.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/9/1.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SwiftOC: NSObject {
    typealias funBlock = (Array<Any>) -> ()
    @objc   var block : funBlock?
    @objc   func getImgae(_ imgView :UIImageView,_ imgPath : String) {

        imgView.kf.setImage(with: URL.init(string: imgPath), placeholder: nil, options: [.forceRefresh])
        imgView.contentMode = .scaleToFill
//        imgView.size = CGSize.init(width: 30.0, height: 30.0)
   }
}
