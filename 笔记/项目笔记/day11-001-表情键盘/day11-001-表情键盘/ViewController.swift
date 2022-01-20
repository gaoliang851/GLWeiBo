//
//  ViewController.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    lazy var emticonInputView = CZEmticonInputView.inputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textView.inputView = emticonInputView
        
        textView .reloadInputViews()
        
    }
}

