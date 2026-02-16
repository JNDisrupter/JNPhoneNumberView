//
//  JNCountry.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import Foundation

/// JNCountry
@objc public protocol JNCountry {
    
    /// Code
    var code: String {set get}
    
    /// Name
    var name: String {set get}
    
    /// Dial code
    var dialCode: String {set get}
}

