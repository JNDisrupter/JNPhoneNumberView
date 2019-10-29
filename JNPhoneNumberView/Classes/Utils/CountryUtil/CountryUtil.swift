//
//  CountryUtil.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 06/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import Foundation
import libPhoneNumber_iOS

/// Country Util
class CountryUtil {
    
    /**
     Generate Flag
     - Parameter countryCode: country code
     - Returns: flag as string
     */
    class func generateFlag(from countryCode: String) -> String {
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
    class func generateDialCode(for regionCode: String) -> JNCountry? {
        
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
     - Parameter dialCode: dial code as string
     - Returns: Country as JNCountry
     */
    class func generateCountryCode(for dialCode: String) -> JNCountry? {
        
        // Modified dial code
        var modifiedDialCode = dialCode
        
        // Check if the first character is "+"
        if modifiedDialCode.first == "+" {
            modifiedDialCode.removeFirst()
        }
        
        // Transform dial code to int
        guard let dialCodeNumber = Int(modifiedDialCode) else { return nil }
        
        // Phone number util
        let phoneNumberUtil = NBPhoneNumberUtil()
        
        // Country code
        if let countryCode = phoneNumberUtil.getRegionCode(forCountryCode: NSNumber(value: dialCodeNumber)) {
            
            // Init and fill country code
            let country = Country()
            country.code = countryCode
            country.dialCode = "+" + modifiedDialCode
            
            // Return country
            return country
        }
        
        return nil
    }
}
