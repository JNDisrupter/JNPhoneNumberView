//
//  PhoneNumberViewAttributes.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 04/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

/// JN Phone Number View Configuration
@objc public class JNPhoneNumberViewConfiguration: NSObject {
    
    /// Country text color
    @objc var countryDialCodeTitleColor: UIColor
    
    /// Country text font
    @objc var countryDialCodeTitleFont: UIFont
    
    /// Phone number text color
    @objc var phoneNumberTitleColor: UIColor
    
    /// Phone number text font
    @objc var phoneNumberTitleFont: UIFont
    
    /// Phone number place holder
    @objc var phoneNumberPlaceHolder: String
    
    /// Done button title
    @objc var doneButtonTitle: String
    
    /**
     Initiailzer
     */
    @objc public override init() {
        
        // set default values
        self.countryDialCodeTitleFont = UIFont.systemFont(ofSize: 15.0)
        self.phoneNumberTitleFont = UIFont.systemFont(ofSize: 15.0)
        self.countryDialCodeTitleColor = UIColor.black
        self.phoneNumberTitleColor = UIColor.black
        self.doneButtonTitle = "Done"
        self.phoneNumberPlaceHolder = ""
    }
}
