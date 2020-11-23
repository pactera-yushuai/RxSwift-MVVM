//
//  YMTHomeNavigaitonController.swift
//  Yamoto
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit


class YMTHomeNavigaitonController: YMTBaseNavigationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
         let image  = imageFromColor(color: UIColor.init(red: 0/255, green: 175/255, blue: 158/255, alpha: 1.0), viewSize: CGSize(width: Int(self.navigationBar.frame.size.width), height: kTopHeight))
        self.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationBar.shadowImage = UIImage()
        
      //  setNavigationUI()
        
      setupTabBarChaildVcNavColor(BackgroundColor: UIColor.white, titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        popPanGesture()
        
      }
    
    
    func setNavigationUI() {
           // 纯色生成一张图片
        let image  = imageFromColor(color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), viewSize: CGSize(width: Int(self.navigationBar.frame.size.width), height: kTopHeight))
           // 设置导航栏背景图片
           self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
           // 设置标题的颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
           // 设置导航栏的透明度
           self.navigationController?.navigationBar.isTranslucent = false
           // 设置导航栏底部线条
           self.navigationController?.navigationBar.shadowImage = UIImage()
           // 设置状态栏的状态
           UIApplication.shared.statusBarStyle = .lightContent
       }
    

    func imageFromColor(color: UIColor, viewSize: CGSize) -> UIImage{
        
         let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
         UIGraphicsBeginImageContext(rect.size)
         let context: CGContext = UIGraphicsGetCurrentContext()!
         context.setFillColor(color.cgColor)
         context.fill(rect)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsGetCurrentContext()
         return image!
    }
}
