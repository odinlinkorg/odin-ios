//
//  BaseTableViewController.swift
//  Wenyishou
//
//  Created by 永芯 on 2020/5/21.
//  Copyright © 2020 永芯. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController, HSTableViewProtocol {

    private lazy var tableView : UITableView = {
           () -> UITableView in
        let tbview = tableViewConfig(CGRect.zero, self, self, .plain)
//        tbview.backgroundColor = vcBackGreyColor
//        tbview.rowHeight = 112
        return tbview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        addRefresh(refreshView: tableView)
    }
    

}

extension BaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()

    }
    
    
}
