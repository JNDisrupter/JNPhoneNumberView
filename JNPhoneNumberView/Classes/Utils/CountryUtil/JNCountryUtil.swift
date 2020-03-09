//
//  JNCountryUtil.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 06/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import Foundation
import libPhoneNumber_iOS

/// JN Country Util
@objc public class JNCountryUtil: NSObject {
    
    /**
     Generate Flag
     - Parameter countryCode: country code
     - Returns: flag as string
     */
    @objc public class func generateFlag(from countryCode: String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for uincodeScalar in countryCode.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + uincodeScalar.value)!)
        }
        return s
    }
    
    /**
     Generate Dial Code
     - Parameter regionCode: region code as string
     - Returns: Country as JNCountry
     */
    @objc public class func generateDialCode(for regionCode: String) -> JNCountry? {
        
        // Init meta data helper
        let metaDataHelper = NBMetadataHelper()
        
        // get meta data for specific region code
        if let metaData = metaDataHelper.getMetadataForRegion(regionCode) {
            
            // Init and fill country code
            let country = Country()
            country.code = regionCode
            country.dialCode = "+" + metaData.countryCode.description
            
            // Return country
            return country
        }
        
        return nil
    }
    
    /**
     Generate Country Code
     - Parameter phoneNumber: phone number as NBPhoneNumber
     - Returns: Country as JNCountry
     */
    @objc public class func generateCountryCode(for phoneNumber: NBPhoneNumber) -> JNCountry? {
        
        // Modified dial code
        var modifiedDialCode = phoneNumber.countryCode.description
        
        // Check if the first character is "+"
        if modifiedDialCode.first == "+" {
            modifiedDialCode.removeFirst()
        }
        
        // Transform dial code to int
        guard let dialCodeNumber = Int(modifiedDialCode) else { return nil }
        
        // Phone number util
        let phoneNumberUtil = NBPhoneNumberUtil()
        
        // Country code
        var generatedRegionCode: String?
        
        // Get region code
        if let regionCode = phoneNumberUtil.getRegionCode(for: phoneNumber) {
            
            generatedRegionCode = regionCode
        }
            
            // Country code
        else if let countryCode = phoneNumberUtil.getRegionCode(forCountryCode: NSNumber(value: dialCodeNumber)) {
            
            generatedRegionCode = countryCode
        }
        
        // Init and fill country code
        var country: JNCountry?
        
        // Check region code
        if let generatedRegionCode = generatedRegionCode {
            
            // Init and fill country code
            country = Country()
            country!.code = generatedRegionCode
            country!.dialCode = "+" + modifiedDialCode
        }
        
        return country
    }
}
