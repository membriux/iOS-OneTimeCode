//
//  ViewController.swift
//  One Time Code
//
//  Created by Memo on 3/10/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var codeTextField: OneTimeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.configure()
        codeTextField.didEnterLastDigit = { [weak self] code in
            // Create an alert after inputting secret code
            guard let alert = Alerts.Success(message: code) else { return }
            self?.present(alert, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        codeTextField.becomeFirstResponder()
    }


}

