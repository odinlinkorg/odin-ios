//
//  SearchViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import TagListView
class SearchViewController: BaseViewController,HSTableViewProtocol {

    private var myContent = 0
        @IBOutlet weak var textField: UITextField!
        var tableView: UITableView!
        var hostArray = [String]()
        var newArray = [String]()
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            tableView =  tableViewConfig(CGRect(x: 0, y: kLiuHaiH + 44.0, width: kScreenWidth, height: kScreenHeight-kLiuHaiH - 44.0), self, self, .plain)

            tableView.backgroundColor = .clear

           
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none
            tableView.estimatedRowHeight = 410
            
            tableView.tableHeaderView = searchTagView
            
            hostArray = ["本周特价","新年福袋","天天","分享甘甜的难得时光","上帝在细节中","充满爱的设计"]
           
            for str in hostArray {
                searchTagView.listViewHost.addTag(str)
            }
            
            loadSearchStory()
          
            searchTagView.listViewNew.delegate = self
            searchTagView.listViewHost.delegate = self
            
            searchTagView.listViewNew.addObserver(self, forKeyPath: "bounds", options: .new, context: &myContent)
            
            /**
             测试
             */
            
        }
        /**
         读取视图数据
         */
        func loadSearchTagView()  {
     
             searchTagView.listViewNew.removeAllTags()
          
            for str in newArray {
                searchTagView.listViewNew.addTag(str)
            }

        }
//        override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//
//            let height = searchTagView.listViewHost.bounds.height + searchTagView.listViewNew.bounds.height + 68
//
//            searchTagView.bounds.size.height =  height
//            tableView.beginUpdates()
//
//            tableView.tableHeaderView = searchTagView
//
//            tableView.endUpdates()
//            print(height)
//            print("高度发生变化")
//
//        }
        lazy var searchTagView: SearchViewHeader = {
//            let view = Bundle.mainBundle.loadNibNamed(String(SearchViewHeader), owner: self, options: nil)?.last as! SearchViewHeader
            
            let view = Bundle.main.loadNibNamed("SearchViewHeader", owner: self, options: nil)?.last as! SearchViewHeader
//
            return view
        }()


        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
          
        }
        /**
         插入搜索记录，不存在则插入
         */
        func insertSearchStory(searchStr: String) {
            for str in newArray {
                guard str != searchStr else{
                    
                    return
                }
            }
            
            let sql = "INSERT INTO t_searchModel(searchStr)VALUES(?);"
            
            SearchDB.shareInstance.db.executeUpdate(sql, withArgumentsIn: [searchStr])
            loadSearchStory()
        }
        /**
         读取最近搜索的历史数据
         */
        func loadSearchStory() {
            
            newArray = []
            
            let sql = "SELECT * FROM t_searchModel;"
            
            let resultSet = SearchDB.shareInstance.db.executeQuery(sql, withArgumentsIn:[])
            
            while resultSet!.next() {
             
                let name = resultSet!.string(forColumn: "searchStr")
                
                newArray.insert(name!, at: 0)
                
            }
            
            loadSearchTagView()

        }

        @IBAction func closeAction(sender: AnyObject) {
            textField.text = ""
            textField.resignFirstResponder()
            
        }
    }
    // MARK: - UITextFieldDelegate
    extension SearchViewController:UITextFieldDelegate{
        private func textFieldShouldReturn(textField: UITextField) -> Bool {
            if textField.text == "" {
             
                return false
            }
            textField.resignFirstResponder()

            insertSearchStory(searchStr: textField.text!)
       
            return true
        }
        
        private func textFieldShouldClear(textField: UITextField) -> Bool {
            
            
            return true
        }
        
    }

    // MARK: - UITableViewDelegate,UITableViewDataSource
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 2
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        
    private func scrollViewDidScroll(scrollView: UIScrollView) {
             textField.resignFirstResponder()
        }
    }
    extension SearchViewController:TagListViewDelegate{
        /**
         点击Item
         
         - parameter title:
         - parameter tagView:
         - parameter sender:
         */
        private func tagPressed(title: String, tagView: TagView, sender: TagListView) -> Void{
            
            insertSearchStory(searchStr: title)
        }

    }
