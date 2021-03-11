//
//  ViewController.swift
//  One Time Code
//
//  Created by Memo on 3/10/21.
//

import UIKit

class VerifyCodeViewController: UIViewController {
    
    
    @IBOutlet weak var codeTextField: OneTimeTextField!
    
    var phone: String?
    var countryCode: String?
    var resultMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.configure()
        // ––––– Verify twilio code after user inputs last digit
        codeTextField.didEnterLastDigit = { code in
            self.verify(code: code)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        codeTextField.becomeFirstResponder()
    }
    
    
    
    
    func verify(code: String) {
        VerifyAPI.validateVerificationCode(self.countryCode!, self.phone!, code) { checked in
            if (checked.success) {
                self.resultMessage = checked.message
                // Create an alert after inputting secret code
                guard let alert = Alerts.success(message: checked.message) else { return }
                self.present(alert, animated: true)
            } else {
                guard let alert = Alerts.fail(message: checked.message) else { return }
                self.present(alert, animated: true)
            }
        }
    }
    
    
    
    
}

