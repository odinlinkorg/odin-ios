//
//  MailDetailsController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import WebKit
import LLCycleScrollView
class MailDetailsController: BaseViewController {
    var bannerView: LLCycleScrollView!
    var tableView: UITableView!
    var webView: WKWebView!
    var goodsId: String!
    var amailLabelDetailsView: MailLabelDetailsView!
   
    var goodsModelItem:TeSeModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "商品详情"
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - NaviBar_Height - kTabBarHeight + 10 ))
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        
        let tableHeaderView = UIView.init(frame:CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (250.0/345.0)*(kScreenWidth - 30.0) + 230 + 64.0 + 67))
        let  bannerViewframe = CGRect.init(x: 15, y: 8 , width: kScreenWidth - 30.0, height: (250.0/345.0)*(kScreenWidth - 30.0))
        bannerView = LLCycleScrollView.init()
        bannerView.frame = bannerViewframe
            
//        let arr = Bundle.main.loadNibNamed("MailLabelDetailsView", owner: nil, options: nil)
//        let mailLabelDetailsView:MailLabelDetailsView = arr![0]  as! MailLabelDetailsView
        let mailLabelDetailsView = MailLabelDetailsView.loadFromNib()
        mailLabelDetailsView.frame = CGRect.init(x: 0, y: bannerView.bottom, width: kScreenWidth , height: 215.0)
        amailLabelDetailsView = mailLabelDetailsView
        
        let arr1 = Bundle.main.loadNibNamed("MailGuiGeDetailsView", owner: nil, options: nil)
        let mailGuiGeDetailsView:MailGuiGeDetailsView = arr1![0]  as! MailGuiGeDetailsView
        mailGuiGeDetailsView.frame = CGRect.init(x: 0, y: mailLabelDetailsView.bottom, width: kScreenWidth , height: 64.0)
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: mailGuiGeDetailsView.width, height: mailGuiGeDetailsView.height))
        button.addTarget(self, action: #selector(guigeAction), for: .touchUpInside)
        mailGuiGeDetailsView.addSubview(button)
        
        let arr2 = Bundle.main.loadNibNamed("MailDetailsTextView", owner: nil, options: nil)
        let mailDetailsTextView:MailDetailsTextView = arr2![0]  as! MailDetailsTextView
        mailDetailsTextView.frame = CGRect.init(x: 0, y: mailGuiGeDetailsView.bottom, width: kScreenWidth , height: 67.0)
        
        
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width:kScreenWidth, height: 0))
      
        tableHeaderView.addSubview(bannerView)
        tableHeaderView.addSubview(mailLabelDetailsView)
        tableHeaderView.addSubview(mailGuiGeDetailsView)
        tableHeaderView.addSubview(mailDetailsTextView)
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = webView
//        tableHeaderView.addSubview(webView)
        webView.navigationDelegate = self
        webView.backgroundColor = .clear
//        let urlRequest = URLRequest(url: URL.init(string: "https://www.baidu.com")!)
        //加载请求
//        webView.load(urlRequest)
        
        let bottomView_H = (80.0/375.0)*screenWidth
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y:kScreenHeight  - kNavBarHeight - kLiuHaiH  - bottomView_H, width: kScreenWidth, height: bottomView_H))
        bottomView.backgroundColor = .white
        let bottomBtn = UIButton.init(frame: CGRect.init(x: 15.0, y:(bottomView_H - 44.0)/2, width:kScreenWidth - 30.0 , height: 44.0))
        bottomBtn.radius = 22.0
        bottomBtn.backgroundColor = .red
        bottomBtn.setTitle("立即购买", for:.normal)
        bottomBtn.addTarget(self, action: #selector(guigeAction), for: .touchUpInside)
        bottomBtn.titleLabel?.font =  UIFont(name: "PingFang-SC-Medium", size: 18)
        bottomBtn.titleLabel?.textColor = .white
        bottomView.addSubview(bottomBtn)
        view.addSubview(bottomView)
//        view.bringSubviewToFront(bottomView)
        
        getGoodsInfoByGoodsId()
    }
    func setgoodsId(_ agoodsId : String){
        goodsId = agoodsId
    }
    
    @objc func guigeAction(){
      
        if goodsModelItem == nil {
            return
        }
        let vc = MaiGuiGelController.init()
        vc.view.backgroundColor = vcBoxBlack
        vc.modalPresentationStyle = .overCurrentContext;
        vc.modalTransitionStyle = .crossDissolve;
        vc.setSpecListArr(agoodsInfoByGoodsIdModel: goodsModelItem)
//
        keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
        vc.block = { [weak self] model  in
            let vc = ConfirmOrderVController.init()
            vc.setaSpecListModel(model,self!.goodsModelItem)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
       func getGoodsInfoByGoodsId(){
        NetworkManager<TeSeModel>().requestModel(API.goodsGetGoodsInfoByGoodsId(aid: goodsId), completion: { (response) in
                if let model = response?.data{
                    self.goodsModelItem = model
                    self.lodeWebViewContent(model.description)
                    
                    let array : Array = model.sliderImage.components(separatedBy: ",")
                    self.bannerView.imagePaths = array
                  
                    self.amailLabelDetailsView.goodsName.text =  model.goodsName
                    self.amailLabelDetailsView.storeNameLabel.text = model.storeName
                    self.amailLabelDetailsView.givePower.text = String(format: "%d", model.givePower) + " 算力"
                    self.amailLabelDetailsView.sales.text = "已售 " + String(format: "%d", model.sales)
                  
                    self.amailLabelDetailsView.priceLabel.text =  String(format: "%.2lf ODIN/", model.odinPrice) + String(format: "%.2lf BGC", model.shopPrice)

                }
            }) { (error) in
                if let msg = error.message {
                MBProgressHUD.showText(msg)
                }
            
        }
    }
    
    func lodeWebViewContent(_ content:String){
//        let content = "<!DOCTYPE html><html> <head><meta charset=\"utf-8\"><title></title><link rel=\"stylesheet\" href=\"css/mycss1.css\" /></head><body><span class=\"demo1\">这是我们的测试</span></body></html>"
        let test =    String(format: "<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@",kScreenWidth - 10.0,content)
        let basePath = Bundle.main.url(forResource: "/JJA", withExtension: nil)
        // 注：baseURL如果设置为nil的话，html中的css将失效
        webView.loadHTMLString(test, baseURL: basePath)
    }
    
 
}


extension MailDetailsController:WKNavigationDelegate{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        

    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
            print(CGFloat(result as! Float))
            self.tableView.tableFooterView?.height = CGFloat(result as! Float) + kNavBarHeight
            self.tableView.reloadData()
        }
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
     
        
    }

    

}
