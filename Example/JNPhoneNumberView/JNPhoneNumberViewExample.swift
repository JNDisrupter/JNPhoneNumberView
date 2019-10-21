//
//  JNPhoneNumberViewExample.swift
//  JNPhoneNumberView_Example
//
//  Created by Hamzawy Khanfar on 10/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JNPhoneNumberView

class JNPhoneNumberViewExample: UIViewController {
    
    /// Phone number view
    @IBOutlet private weak var phoneNumberView: JNPhoneNumberView!
    
    /// Phone number label
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    
    /**
     View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "JN Phone Number View Example"
        
        // Set delegate
        self.phoneNumberView.delegate = self
        self.phoneNumberView.setDefaultCountryCode("US")
        self.phoneNumberView.backgroundColor = UIColor.gray
        self.phoneNumberView.setViewConfiguration(self.getConfigration())
        self.phoneNumberView.setPhoneNumber("")
        self.phoneNumberView.layer.cornerRadius = 5.0
        self.phoneNumberView.layer.borderColor = UIColor.lightGray.cgColor
        self.phoneNumberView.layer.borderWidth = 1.0
        self.phoneNumberView.backgroundColor = UIColor.lightGray
    }
    
}

extension JNPhoneNumberViewExample: JNPhoneNumberViewDelegate {
    
    /**
     Get presenter view controller
     - Returns: presenter view controller
     */
    func phoneNumberViewGetPresenterViewController() -> UIViewController {
        return self
    }
    
    /**
     Get country code picker attributes
     */
    func phoneNumberViewGetCountryPickerAttributes() -> JNCountryPickerConfiguration {
        let configuration = JNCountryPickerConfiguration()
        configuration.pickerLanguage = .en
        configuration.tableCellInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        configuration.viewBackgroundColor = UIColor.lightGray
        configuration.tableCellBackgroundColor = UIColor.white
        
        return configuration
    }
    
    /**
     Did change text
     - Parameter text: New text.
     - Parameter cellIndex: Cell index
     */
    func phoneNumberView(didChangeText text: String) {
        self.phoneNumberLabel.text = "International Phone Number: \n \(text)"
    
        self.phoneNumberView.setViewConfiguration(self.getConfigration())
    }
    
    /**
     Did end editing
     - Parameter text: New text.
     - Parameter isValidPhoneNumber: Is valid phone number flag as bool
     */
    func phoneNumberView(didEndEditing text: String, isValidPhoneNumber: Bool) {
        let validationMessage = isValidPhoneNumber ? "Valid Phone Number" : "Invalid Phone Number"
        self.phoneNumberLabel.text = "International Phone Number: \n \(text) \n \(validationMessage)"
        
        self.phoneNumberLabel.textColor = isValidPhoneNumber ? UIColor.blue : UIColor.red
    }
    
    /**
     Country Did Changed
     - Parameter country: New Selected Country
     - Parameter isValidPhoneNumber: Is valid phone number flag as bool
     */
    func phoneNumberView(countryDidChanged country: JNCountry, isValidPhoneNumber: Bool) {
        let validationMessage = isValidPhoneNumber ? "Valid Phone Number" : "Invalid Phone Number"
        self.phoneNumberLabel.text = "International Phone Number: \n \(self.phoneNumberView.getPhoneNumber()) \n \(validationMessage)"
        
        self.phoneNumberLabel.textColor = isValidPhoneNumber ? UIColor.blue : UIColor.red
    }
    
    private func getConfigration() -> JNPhoneNumberViewConfiguration {
        let configrartion = JNPhoneNumberViewConfiguration()
        configrartion.phoneNumberTitleColor = UIColor.white
        configrartion.countryDialCodeTitleColor = UIColor.white
        
        return configrartion
    }
}

