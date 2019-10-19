//
//  GeneralResource.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

/// General Resource Type
enum GeneralResourceType  {
    case loading
    case emptyDataWithImage
    case emptyDataOnly
}

/// General Resource
class GeneralResource {
    
    /// Resource Data
    var displayText: String!
    
    /// Display Image Name
    var displayImageName: String!
    
    /// Resouce Type
    var type: GeneralResourceType!
    
    /**
     Initializer
     */
    init() {
        
        // Init Resource Data
        self.displayText = ""
        
        // Init Display Image Name
        self.displayImageName = ""
        
        // Init Resouce Type
        self.type = GeneralResourceType.loading
    }
    
    /**
     Get Loading General Resource.
     - Returns: Loading General Resource.
     */
    class func getLoadingGeneralResource() -> GeneralResource {
        
        //Init General Resource
        let generalResourceData = GeneralResource()
        
        //Set Text
        generalResourceData.displayText = ""
        
        //Set Type
        generalResourceData.type = GeneralResourceType.loading
        
        return generalResourceData
    }
    
    /**
     Get General Resource Identifier
     - Returns: General Resource Identifier as String
     */
    static func getIdentifier() -> String {
        return "GeneralResourceIdentifier"
    }
}
