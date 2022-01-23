//
//  ViewController.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    lazy var emticonInputView = CZEmticonInputView.inputView { emticon in
        print(emticon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //emticonInputView.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        
        textView.inputView = emticonInputView
        
        textView .reloadInputViews()
        
    }
}

