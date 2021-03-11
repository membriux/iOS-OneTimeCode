//
//  OneTimeTextField.swift
//  One Time Code
//
//  Created by Memo on 3/10/21.
//

import UIKit

class OneTimeTextField: UITextField {

    var didEnterLastDigit: ((String) -> Void)?
    
    var defaultChar = "_"
    
    private var isConfigured = false
    
    private var digitLabels = [UILabel]()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    func configure(with slotCount: Int = 6) {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        
        configureTextField()
        
        let labelsStackView = createLabelStackView(with: slotCount)
        addSubview(labelsStackView)
        
        addGestureRecognizer(tapRecognizer)
        
        // Fill up text field size from Storyboard
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        
        // Update text
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }

    
    private func createLabelStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        
        // Add autolyout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        // Create labels with autolatyout
        for _ in 1 ... count {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 40)
            label.isUserInteractionEnabled = true
            label.text = defaultChar
            
            stackView.addArrangedSubview(label)
            
            digitLabels.append(label)
        }
        
        return stackView
    }
    
    
    @objc
    private func textDidChange() {
        // prevent user from typing more digits than the code length
        guard let text = self.text, text.count <= digitLabels.count else { return }
        
        // Loob through labels that we have in our array and update them
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text = defaultChar
            }
        }
        
        if text.count == digitLabels.count {
            didEnterLastDigit?(text)
        }
    }
    
}

extension OneTimeTextField: UITextFieldDelegate {
    
    
    // Prevent user from typing more characters than the required amount (i.e. no more than 6 chars)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let charCount = textField.text?.count else { return false }
        return charCount < digitLabels.count || string == ""
    }
    
}
