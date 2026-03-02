//
//  GeneralResourceTableViewCellRepresentable.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

/// General Resource Table View Cell Representable
class GeneralResourceTableViewCellRepresentable: TableViewCellRepresentable {
    
    /// Cell height
    var cellHeight: CGFloat
    
    /// Date index
    var itemDataIndex: Int
    
    /// Resource Text
    private(set) var text: NSAttributedString
    
    /// Resource Image Name
    private(set) var imageName: String
    
    /// Resouce Type
    private(set) var type: GeneralResourceType
    
    /**
     Initializer
     */
    init() {
        
        // Set values
        self.cellHeight = 0.0
        self.itemDataIndex = -1
        self.text = NSAttributedString()
        self.imageName = ""
        self.type = GeneralResourceType.emptyDataWithImage
    }
    
    /**
     Initializer
     - Parameter generalResource: General resource.
     */
    convenience init(generalResource: GeneralResource) {
        self.init()
        
        self.text = NSAttributedString(string: generalResource.displayText)
        self.imageName = generalResource.displayImageName
        self.type = generalResource.type
    }
}
