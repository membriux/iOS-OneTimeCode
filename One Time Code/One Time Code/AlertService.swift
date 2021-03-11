//
//  AlertService.swift
//  One Time Code
//
//  Created by Memo on 3/10/21.
//

import Foundation
import UIKit

class Alerts {
    
    static func Success(message: String) -> UIAlertController? {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        return alertController
    }
    
}


