//
//  YMTBaseViewController.swift
//  Yamoto
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift

#if os(iOS)
    import UIKit
    typealias YMTOSViewController = UIViewController
#elseif os(macOS)
    import Cocoa
    typealias YMTOSViewController = NSViewController
#endif

class YMTBaseViewController: YMTOSViewController {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *) {
                  UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
              } else {
                  automaticallyAdjustsScrollViewInsets = false
              }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
