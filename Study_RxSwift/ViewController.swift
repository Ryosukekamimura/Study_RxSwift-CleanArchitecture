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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input_box_1.rx.text.orEmpty.bind(to: display_add_number.rx.text).disposed(by: disposeBag)
        input_box_2.rx.text.orEmpty.bind(to: display_add_number.rx.text).disposed(by: disposeBag)
        input_box_3.rx.text.orEmpty.bind(to: display_add_number.rx.text).disposed(by: disposeBag)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

