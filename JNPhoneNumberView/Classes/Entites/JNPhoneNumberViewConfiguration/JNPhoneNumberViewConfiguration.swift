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
    @objc public var countryDialCodeTitleColor: UIColor
    
    /// Country text font
    @objc public var countryDialCodeTitleFont: UIFont
    
    /// Phone number text color
    @objc public var phoneNumberTitleColor: UIColor
    
    /// Phone number text font
    @objc public var phoneNumberTitleFont: UIFont
    
    /// Phone number place holder
    @objc public var phoneNumberPlaceHolder: String
    
    /// left ToolBar BarButtonItem Title
    @objc public var leftToolBarBarButtonItemTitle: String
    
    /// View background color
    @objc public var viewBackgroundColor: UIColor
    
    /**
     Initiailzer
     */
    @objc public override init() {
        
        // set default values
        self.countryDialCodeTitleFont = UIFont.systemFont(ofSize: 15.0)
        self.phoneNumberTitleFont = UIFont.systemFont(ofSize: 15.0)
        self.countryDialCodeTitleColor = UIColor.black
        self.phoneNumberTitleColor = UIColor.black
        self.leftToolBarBarButtonItemTitle = "Done"
        self.phoneNumberPlaceHolder = ""
        self.viewBackgroundColor = UIColor.clear
    }
}
