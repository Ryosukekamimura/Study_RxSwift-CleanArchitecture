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

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textFiled3: UITextField!
    @IBOutlet weak var displayNum: UILabel!
    
    
    let disposeBag = DisposeBag()
    
    func numCheck(str: String) -> Int {
        return (Int(str) ?? 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty, textFiled3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return self.numCheck(str: textValue1) + self.numCheck(str: textValue2) + self.numCheck(str: textValue3)
        }
        .map{ $0.description }
        .bind(to: displayNum.rx.text)
        .disposed(by: disposeBag)
        
        
        
    }
}

