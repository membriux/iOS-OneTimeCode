//
//  PhoneNumberTextField.swift
//  One Time Code
//
//  Created by Memo on 3/11/21.
//

import UIKit

class PhoneNumberTextField: UITextField {
    
    func configure() {
        delegate = self
        keyboardType = .numberPad
        placeholder = "(123) 456 - 7890"
    }
    
}

extension PhoneNumberTextField: UITextFieldDelegate {
        
    
    // Format Text field to Phone Number --> (xxx) xxx -xxxx instead of random string positions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)

        let decimalString = components.joined(separator: "") as NSString
        let length = decimalString.length
        let hasLeadingOne = length > 0 && decimalString.hasPrefix("1")

        if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

            return (newLength > 10) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()

        if hasLeadingOne {
            formattedString.append("1 ")
            index += 1
        }
        if (length - index) > 3 {
            let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("(%@) ", areaCode)
            index += 3
        }
        if length - index > 3 {
            let prefix = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("%@ - ", prefix)
            index += 3
        }

        let remainder = decimalString.substring(from: index)
        formattedString.append(remainder)
        textField.text = formattedString as String
        return false
        
    }
    
    
}

