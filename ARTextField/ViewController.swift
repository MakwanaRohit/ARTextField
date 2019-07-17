//
//  ViewController.swift
//  ARTextField
//
//  Created by Rohit Makwana on 17/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var identierTextField: ARTextField!
    @IBOutlet var passwordTextField: ARTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.identierTextField.placeHolderColor = UIColor.orange
        self.identierTextField.underLineColor = UIColor.orange
        self.identierTextField.placeholderLabelFont = UIFont.systemFont(ofSize: 13.0)
    }
}

