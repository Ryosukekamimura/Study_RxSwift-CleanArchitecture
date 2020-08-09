//
//  ViewController.swift
//  Study_RxSwift
//
//  Created by 神村亮佑 on 2020/08/08.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5


class ViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "RxSwift", message: "RxSwift is fun", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameErrorLabel.text = "ユーザーネームは、\(minimalUsernameLength)以上です。"
        passwordErrorLabel.text = "パスワードは、\(minimalPasswordLength)以上です。"
        
        
        let userNameValid = usernameTextField.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passWordValid = passwordTextField.rx.text.orEmpty
            .map{ $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(userNameValid, passWordValid){ $0 && $1 }
            .share(replay: 1)
        
        userNameValid.bind(to: passwordTextField.rx.isEnabled).disposed(by: disposeBag)
        userNameValid.bind(to: usernameErrorLabel.rx.isHidden).disposed(by: disposeBag)
        
        passWordValid.bind(to: passwordErrorLabel.rx.isHidden).disposed(by: disposeBag)
        
        everythingValid.bind(to: addButton.rx.isEnabled).disposed(by: disposeBag)
        everythingValid.bind(to: addButton.rx.isEnabled).disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
