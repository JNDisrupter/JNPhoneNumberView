//
//  Country.swift
//  JNPhoneNumberView
//
//  Created by Hamzawy Khanfar on 16/10/2019.
//

import Foundation

/// Country Code Json Tag
private enum CountryJsonTag: String {
    case code
    case name
    case dialCode          = "dial_code"
}

/// Country
class Country: NSObject, JNCountry {
    
    /// Code
    var code: String
    
    /// Name
    var name: String
    
    /// Dial code
    var dialCode: String
    
    /**
     Initializer
     */
    override init() {
        
        // Init intial values
        self.code = ""
        self.name = ""
        self.dialCode = ""
    }
    
    /**
     Init with Representation
     - Parameter representation: Representation as Dictionary
     */
    convenience init(representation: NSDictionary) {
        self.init()
        
        // Set code
        if let value = representation.value(forKey: CountryJsonTag.code.rawValue) as? String {
            self.code = value
        }
        
        // Set name
        if let value = representation.value(forKey: CountryJsonTag.name.rawValue) as? String {
            self.name = value
        }
        
        // Set area code
        if let value = representation.value(forKey: CountryJsonTag.dialCode.rawValue) as? String {
            self.dialCode = value
        }
    }
}
