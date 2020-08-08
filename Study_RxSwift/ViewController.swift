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
    
    
    
    
    @IBOutlet weak var input_box_1: UITextField!
    
    @IBOutlet weak var input_box_2: UITextField!
    @IBOutlet weak var input_box_3: UITextField!
    @IBOutlet weak var display_add_number: UILabel!
    
    
    let disposeBag = DisposeBag()
    
    func checknumber(str: String) -> Int {
        return (Int(str) ?? 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(input_box_1.rx.text.orEmpty, input_box_2.rx.text.orEmpty, input_box_3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return self.checknumber(str: textValue1) + self.checknumber(str: textValue2) + self.checknumber(str: textValue3)
        }
        .map{ $0.description }
        .bind(to: display_add_number.rx.text)
        .disposed(by: disposeBag)
        
        
        
    }
}

