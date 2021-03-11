//
//  ViewController.swift
//  One Time Code
//
//  Created by Memo on 3/10/21.
//

import UIKit

class VerifyCodeViewController: UIViewController {
    
    
    @IBOutlet weak var codeTextField: OneTimeTextField!
    @IBOutlet weak var verificationStatusLabel: UILabel!
    
    var phone: String?
    var countryCode: String?
    var resultMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        codeTextField.becomeFirstResponder()
    }

    
    // ––––– Verify twilio code after user inputs 6 digits
    @IBAction func codeChanged(_ sender: Any) {
        print("CODE:", codeTextField.text!)
        if codeTextField.text?.count == 6 {
            if let code = codeTextField.text {
                VerifyAPI.validateVerificationCode(self.countryCode!, self.phone!, code) { checked in
                    if (checked.success) {
                        self.resultMessage = checked.message
                        self.verificationStatusLabel.text = checked.message
                        // Create an alert after inputting secret code
                        guard let alert = Alerts.Success(message: code) else { return }
                        self.present(alert, animated: true)
                    } else {
                        self.verificationStatusLabel.text = checked.message
                    }
                }
            }
        }
        
    }
    
    
    
    
}

