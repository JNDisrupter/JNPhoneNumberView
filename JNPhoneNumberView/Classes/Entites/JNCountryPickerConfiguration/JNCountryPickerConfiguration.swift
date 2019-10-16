//
//  JNCountryPickerConfiguration.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

/// Country Picker Language
@objc public enum JNCountryPickerLanguage: Int {
    case en
    case ar
    
    /**
     Get File Name
     - Returns: file name as string
     */
    internal func getFileName() -> String {
        
        // Check self
        switch self {
        case .en:
            return "countries_en"
        case .ar:
            return "countries_ar"
        }
    }
}

/// Country picker configuration
@objc public class JNCountryPickerConfiguration: NSObject {
    
    /// Selected title font
    @objc public var selectedTitleFont: UIFont
    
    /// title font
    @objc public var titleFont: UIFont
    
    /// Selected title color
    @objc public var selectedTitleColor: UIColor
    
    /// title color
    @objc public var titleColor: UIColor
    
    /// Empty search message font
    @objc public var emptySearchMessageFont: UIFont
    
    /// Empty search message color
    @objc public var emptySearchMessageColor: UIColor
    
    /// Navigation Bar color
    @objc public var navigationBarColor: UIColor
    
    /// Navigation Bar tint color
    @objc public var naigationBarTintColor: UIColor
    
    /// Navigation bar title
    @objc public var navigationBarTitle: String
    
    /// Select bar button title
    @objc public var selectBarButtonTitle: String
    
    /// Loading activiy indictor color
    @objc public var loadingAcivityIndicatorColor: UIColor
    
    /// empty search message
    @objc public var emptySearchMessage: String
    
    /// Empty search image
    @objc public var emptySearchImage: UIImage
    
    /// View background color
    @objc public var viewBackgroundColor: UIColor
    
    /// Picker language
    @objc public var pickerLanguage: JNCountryPickerLanguage
    
    /**
     Initializer
     */
    @objc public override init() {
        
        // Set default values
        self.selectedTitleFont = UIFont.systemFont(ofSize: 15.0)
        self.titleFont = UIFont.systemFont(ofSize: 15.0)
        self.emptySearchMessageFont = UIFont.systemFont(ofSize: 15.0)
        self.selectedTitleColor = UIColor.black
        self.titleColor = UIColor.black
        self.emptySearchMessageColor = UIColor.black
        self.naigationBarTintColor = UIColor.black
        self.navigationBarColor = UIColor.white
        self.selectBarButtonTitle = "Select"
        self.loadingAcivityIndicatorColor = UIColor.black
        self.navigationBarTitle = "Select Country"
        self.emptySearchMessage = "No Results"
        self.emptySearchImage = UIImage(named: "EmptySearchResult", in: Bundle(for: JNCountryPickerViewController.self), compatibleWith: nil)!
        self.viewBackgroundColor = UIColor.gray
        self.pickerLanguage = .en
    }
}
