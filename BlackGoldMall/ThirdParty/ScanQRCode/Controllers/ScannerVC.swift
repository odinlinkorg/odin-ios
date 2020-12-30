//
//  ScannerVC.swift
//  SwiftScanner
//
//  Created by Jason on 2018/11/30.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit
import AVFoundation

public class ScannerVC: UIViewController{
    
    
    public lazy var headerViewController:HeaderVC = .init()
    
    public lazy var cameraViewController:CameraVC = .init()
    
    /// 动画样式
    public var animationStyle:ScanAnimationStyle = .default{
        didSet{
            cameraViewController.animationStyle = animationStyle
        }
    }
    
    // 扫描框颜色
    public var scannerColor:UIColor = .red{
        didSet{
            cameraViewController.scannerColor = scannerColor
        }
    }
    
    public var scannerTips:String = ""{
        didSet{
           cameraViewController.scanView.tips = scannerTips
        }
    }
    
    /// `AVCaptureMetadataOutput` metadata object types.
    public var metadata = AVMetadataObject.ObjectType.metadata {
        didSet{
            cameraViewController.metadata = metadata
        }
    }
    
    public var successBlock:((String)->())?
    
    public var errorBlock:((Error)->())?
    

      
    
    
    /// 设置标题
    public override var title: String?{
        
        didSet{
            
            if navigationController == nil {
                headerViewController.title = title
            }
        }
        
    }
    
    
    /// 设置Present模式时关闭按钮的图片
    public var closeImage: UIImage?{
        
        didSet{
            
            if navigationController == nil {
                headerViewController.closeImage = closeImage ?? UIImage()
            }
        }
        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cameraViewController.startCapturing()
    }
    
 
    
}




// MARK: - CustomMethod
extension ScannerVC{
    
    func setupUI() {
        
        if title == nil {
            title = Localized("扫一扫")
        }
        
        view.backgroundColor = .black
        
        headerViewController.delegate = self
        
        cameraViewController.metadata = metadata
        
        cameraViewController.animationStyle = animationStyle
        
        cameraViewController.delegate = self
        
        add(cameraViewController)
        
        if navigationController == nil {
            
            add(headerViewController)
            
            view.bringSubviewToFront(headerViewController.view)
            
        } else {
            
            let rightBarItem = UIBarButtonItem.init(title: Localized("相册"), style: .plain, target: self, action: #selector(clickOpenPhoto))
            navigationItem.rightBarButtonItem = rightBarItem;
            
            let img = UIImage(named: "icon_back")
            let barButtonItem = UIBarButtonItem.init(image: img, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickLeftItem))
            self.navigationItem.leftBarButtonItem = barButtonItem
        }
        
        
    }
    
    @objc func clickLeftItem() {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    public func setupScanner(_ title:String? = nil, _ color:UIColor? = nil, _ style:ScanAnimationStyle? = nil, _ tips:String? = nil, _ success:@escaping ((String)->())){
        
        if title != nil {
            self.title = title
        }
        
        if color != nil {
            scannerColor = color!
        }
        
        if style != nil {
            animationStyle = style!
        }
        
        if tips != nil {
            scannerTips = tips!
        }
        
        successBlock = success
        
    }
    
    
}




// MARK: - HeaderViewControllerDelegate
extension ScannerVC:HeaderViewControllerDelegate{
    ///
    @objc public func clickOpenPhoto() {
//        Unitilty.photoAlbumPermissions(authorizedBlock: { [weak self] in
//            print("打开相册")
//          if let strongSelf = self {
//            }
//        }, deniedBlock: {
//            print("没有权限打开相册")
//        })
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate = self;
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    /// 点击关闭
    public func didClickedCloseButton() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
}



extension ScannerVC:CameraViewControllerDelegate{
    
    func didOutput(_ code: String) {
        
        successBlock?(code)
        back()
        
    }
    
    func didReceiveError(_ error: Error) {
        
        errorBlock?(error)
        back()
    }
    
    
    func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ScannerVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - ----相册选择图片识别二维码
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        var image:UIImage? = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        if (image == nil )
        {
            image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }

        if(image == nil) {
            return
        }

        if(image != nil) {
            let codeStr = cameraViewController.recognizeQRImage(image: image!)
            successBlock?(codeStr)
            dismiss(animated: true, completion: nil)
        }
    }
}
