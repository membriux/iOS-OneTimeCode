//
//  EnterPhoneViewController.swift
//  One Time Code
//
//  Created by Memo on 3/11/21.
//

import UIKit

class EnterPhoneViewController: UIViewController {
    
    
    @IBOutlet weak var phoneTextField: PhoneNumberTextField!
    
    let countryCode = "+1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.configure()
        phoneTextField.addTarget(self, action: #selector(phoneChanged(_:)), for: .editingChanged)


        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        phoneTextField.becomeFirstResponder()
    }
    
    
    
    @IBAction func verify(_ sender: Any) {
        // Send verification Request
        if let phoneNumber = phoneTextField.text {
            VerifyAPI.sendVerificationCode(countryCode, phoneNumber)
        }
    }
    
    
    @objc
    func phoneChanged(_ textField: UITextField) {
        print("Phone Change")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? VerifyCodeViewController {
            vc.countryCode = self.countryCode
            vc.phone = self.phoneTextField.text
        }
    }
    
    
    
}
