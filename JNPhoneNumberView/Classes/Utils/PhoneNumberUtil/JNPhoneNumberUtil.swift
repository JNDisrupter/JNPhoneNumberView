//
//  JNPhoneNumberUtil.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 07/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import Foundation
import libPhoneNumber_iOS

/// JNPhone Number Util
@objc public class JNPhoneNumberUtil: NSObject {
    
    /**
     Is Phone Number Valid
     - Parameter phoneNumber: phone number as string
     - Parameter defaultRegion: default region as string
     - Returns: flag to indicates
     */
    @objc public class func isPhoneNumberValid(phoneNumber: String, defaultRegion: String) -> Bool {
        
        // Init phone number util
        let phoneNumberUtil = NBPhoneNumberUtil()
        
        // Parse phone number
        if let parsedPhoneNumber = JNPhoneNumberUtil.parsePhoneNumber(phoneNumber, defaultRegion: defaultRegion) {
            return phoneNumberUtil.isValidNumber(parsedPhoneNumber)
        }
        
        return false
    }
    
    /**
     Parse Phone Number
     - Parameter phoneNumber: phone number as string
     - Parameter defaultRegion: default region as string
     - Returns: parsed phone number as NBPhoneNumber
     */
    @objc public class func parsePhoneNumber(_ phoneNumber: String, defaultRegion: String) -> NBPhoneNumber? {
        
        // Init phone number util
        let phoneNumberUtil = NBPhoneNumberUtil()
        
        // Parse phone number
        do {
            // Parse phone number
            let phoneNumber = try phoneNumberUtil.parse(phoneNumber, defaultRegion: defaultRegion)
            
            // Return phone number
            return phoneNumber
        } catch {
            
            // National number
            var nationalNumber: NSString? = nil
              
            // Dial code
            let dialCode = phoneNumberUtil.extractCountryCode(phoneNumber, nationalNumber: &nationalNumber)
            
            // Check if dial code or national phone number not detected
            if (dialCode?.description ?? "").isEmpty  || nationalNumber == nil {
                return  nil
            }
            
            // Create phone number object
            let nbPhoneNumber = NBPhoneNumber()
            
            // Set dial code
            nbPhoneNumber.countryCode = dialCode
            
            // Check if national number not empty
            if nationalNumber!.length > 0 {
                
                // Convert national number from string to number
                let nationalPhoneNumber = NSNumber(value: nationalNumber!.floatValue)
                
                // set national number
                nbPhoneNumber.nationalNumber = nationalPhoneNumber
            }
            
            return nbPhoneNumber
        }
    }
}
