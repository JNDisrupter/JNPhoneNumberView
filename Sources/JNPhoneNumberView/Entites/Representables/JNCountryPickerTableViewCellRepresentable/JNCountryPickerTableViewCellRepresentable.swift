//
//  HarriPickerTableViewCellRepresentable.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//
import UIKit

/// Country picker Table View Cell Representable
class JNCountryPickerTableViewCellRepresentable: TableViewCellRepresentable {
    
    /// Cell height
    var cellHeight: CGFloat
    
    /// Date index
    var itemDataIndex: Int

    /// Country name attributed string
    private(set) var countryNameAttributedString: NSAttributedString
    
    /// Selected Country Name Attributes
    private var selectedCountryNameAttributes: [NSAttributedString.Key : Any]
    
    /// Normal Country Code Attributes
    private var normalCountryNameAttributes: [NSAttributedString.Key : Any]
    
    /// Is selected
    private(set) var isSelected: Bool
    
    /// Flag Attributed String
    private(set) var flagAttributedString: NSAttributedString
    
    
    /**
     Initializer
     */
    init() {
        
        // Set values
        self.cellHeight = JNCountryPickerTableViewCell.getCellHeight()
        self.itemDataIndex = -1
        self.countryNameAttributedString = NSAttributedString()
        self.selectedCountryNameAttributes = [:]
        self.normalCountryNameAttributes = [:]
        self.isSelected = false
        self.flagAttributedString = NSAttributedString()
    }
    
    /**
     Initializer
     - Parameter flag: flag as string
     - Parameter title: title as string
     - Parameter isSelected: Is selected indicator
     - Parameter selectedCountryNameAttributes: Selected Title Attributes
     - Parameter normalCountryNameAttributes: Normal Title Attributes
     */
    convenience init(flag: String, title: String, isSelected: Bool, selectedCountryNameAttributes: [NSAttributedString.Key : Any] = [ : ], normalCountryNameAttributes: [NSAttributedString.Key : Any] = [ : ]) {
        
        // Init
        self.init()
        
        // Set is selected and has details
        self.isSelected = isSelected
        
        // Set selected country name attributes
        self.selectedCountryNameAttributes = selectedCountryNameAttributes
        
        // Set normal country name attributes
        self.normalCountryNameAttributes = normalCountryNameAttributes
        
        // Check if selected to set string attributes
        let titleStringAttributes = self.isSelected ? self.selectedCountryNameAttributes : self.normalCountryNameAttributes
        
        // Build flag attributes
        var flagAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : titleStringAttributes[NSAttributedString.Key.font] ?? UIFont.systemFont(ofSize: 15.0)]
        
        // Find font and adjust the font size
        if let font = flagAttributes[NSAttributedString.Key.font] as? UIFont {
            
            // new font
            let newFont = font.withSize(font.pointSize + 20.0)
            
            // set font with new size
            flagAttributes[NSAttributedString.Key.font] = newFont
        }
        
        // Init flag attributed string
        self.flagAttributedString = NSAttributedString(string: flag, attributes: flagAttributes)
        
        // Append title attributed string
        self.countryNameAttributedString = NSAttributedString(string: title, attributes: titleStringAttributes)
    }
    
    /**
     Set Selected
     - Parameter isSelected: To Indicate Is Selected
     */
    func setSelected(_ isSelected: Bool) {
        
        // Set Selected
        self.isSelected = isSelected
        
        // Check if selected to set string attributes
        let titleStringAttributes = isSelected ? self.selectedCountryNameAttributes : self.normalCountryNameAttributes
        
        // Set title attributed string
        self.countryNameAttributedString = NSAttributedString(string: self.countryNameAttributedString.string, attributes: titleStringAttributes)
    }
}
