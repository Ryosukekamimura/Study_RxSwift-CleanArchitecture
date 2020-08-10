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
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var stateSegmentControl: UISegmentedControl!
    @IBOutlet weak var freeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    
    @IBOutlet weak var greetingButtons: UIButton!
    
    
    
    //観測オブジェクト対象の一括解放
    let disposedBag = DisposeBag()
    
    //SegmentControllに対応する値の定義
    enum State: Int {
        case useButtons
        case useTextField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //「お名前：」の入力フィールドにおいて、テキスト入力のイベントを観測対象にする
        let nameObservable: Observable<String?> = nameTextField.rx.text.asObservable()
        
        //「自由入力：」の入力フィールドにおいて、テキスト入力のイベントを観測対象にするn
        let freeObservable: Observable<String?> = freeTextField.rx.text.asObservable()
        
        
        //Observable.combineLatestで「お名前：」と「自由入力：」を結合する
        let freewordWithNameObservable: Observable<String?> = Observable.combineLatest(
            nameObservable,
            freeObservable
        ) { (string1: String?, string2: String?) in
                return string1! + string2!
        }
        
        
        freewordWithNameObservable.bind(to: greetingLabel.rx.text).disposed(by: disposedBag)
        
        let segmentObservableControl: Observable<Int> = stateSegmentControl.rx.value.asObservable()
        
        let stateObservable: Observable<State> = segmentObservableControl.map{
            (selectedIndex: Int) -> State in
            return State(rawValue: selectedIndex)!
        }
        
        let greetingTextFieldObservable: Observable<Bool> = stateObservable.map {
            (state: State) -> Bool in
            return state == .useTextField
        }
        
        greetingTextFieldObservable.bind(to: freeTextField.rx.isEnabled).disposed(by: disposedBag)
        
        
        let buttonsEnabledObservable: Observable<Bool> = greetingTextFieldObservable{
            (greetingEnabled: Bool) -> Bool in
                return !greetingEnabled
        }
        
        
        greetingButtons.forEach{ button in
            buttonsEnabledObservable.bind(to: button.rx.isEnabled).disposed(by: disposedBag)
            
            button.rx.tap.subscribe(onNext: { (nothing: Void) in
                self.lastSelectedGreeting.value = button.currentTitle!
                
            }).disposed(by: disposedBag)
        }
        
        
        let predefinedGreetingObservable: Observable<String> = lastSelectedGreeting.asObservable()
        
        let finalGreetingObservable: Observable<String> = Obsevable.combineLasted(stateObservable, freeObservable, predefinedGreetingObservable, nameObservable) { (state: State, freeword: String?, predefinedGreeting: String, name: String?) -> String in
            
            switch state {
                case .useTextField: return freewor! + name!
                case .useButtons:  return predefinedGreeting + name!
            }
        }
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
