//
//  YMTLoginViewController.swift
//  Yamoto
//
//  Created by pactera on 2020/10/27.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class YMTLoginViewController: YMTBaseViewController {

    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var Login: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
  
        usernameLabel.text =  NSLocalizedString("UserName", comment: "")
        passwordLabel.text =  NSLocalizedString("PassWord", comment: "")
        
        usernameValidOutlet.text = NSLocalizedString("UsernameValid", comment: "")
        passwordValidOutlet.text = NSLocalizedString("PasswordValid", comment: "")
        
        let usernameValid = usernameOutlet.rx.text.orEmpty
                        .map { $0.count >= 5 }
                        .share(replay: 1)
        
        let passWordValid = passwordOutlet.rx.text.orEmpty
                        .map{ $0.count >= 5 }
                        .share(replay: 1)
        
        let loginValid = Observable.combineLatest(usernameValid,passWordValid)
            .map{ $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        passWordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        loginValid
            .bind(to: Login.rx.isEnabled)
            .disposed(by: disposeBag)
        
        Login.rx.tap
            .subscribe(onNext :{ [weak self] _ in
                self?.signin()
            })
            .disposed(by: disposeBag)
    }
    
    func signin(){
        

        
        let alert = DefaultWireframe.shared
        
        _ =  alert.promptFor("登入吧", cancelAction: "OK", actions: [])
                    .map{ $0  }
                    .share(replay: 1)
     
        
        
//        let alert = UIAlertController(
//            title: "可以登入了",
//            message: "登陆逻辑编写",
//            preferredStyle: .alert
//        )
//
//        alert.view.backgroundColor = .white
//        show(alert, sender: nil)
    }
  
}
