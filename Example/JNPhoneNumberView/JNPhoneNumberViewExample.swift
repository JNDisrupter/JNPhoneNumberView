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
        self.phoneNumberView.setDefaultCountryCode("PS")
        self.phoneNumberView.backgroundColor = UIColor.gray
        self.phoneNumberView.setViewConfiguration(JNPhoneNumberViewConfiguration())
        self.phoneNumberView.setPhoneNumber("123123123")
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
        
        let configration =  JNPhoneNumberViewConfiguration()
        configration.phoneNumberTitleColor = UIColor.black
        
        self.phoneNumberView.setViewConfiguration(configration)
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
        let configration =  JNPhoneNumberViewConfiguration()
        configration.phoneNumberTitleColor = isValidPhoneNumber ? UIColor.green : UIColor.red
        self.phoneNumberView.setViewConfiguration(configration)
    }
}

