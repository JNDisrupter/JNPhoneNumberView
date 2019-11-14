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
    
    /// Search bar tint Color
    @objc public var searchBarTintColor: UIColor
    
    /// Navigation Bar color
    @objc public var navigationBarColor: UIColor
    
    /// Navigation Bar tint color
    @objc public var naigationBarTintColor: UIColor
    
    /// Navigation bar title
    @objc public var navigationBarTitle: String
    
    /// Navigation bar title Text Attributtes
    @objc public var navigationBarTitleTextAttributes: [NSAttributedString.Key : Any]
    
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
    
    /// Table cell insets
    @objc public var tableCellInsets: UIEdgeInsets
    
    /// Table cell corner raduis
    @objc public var tableCellCornerRaduis: CGFloat
    
    /// Table cell background color
    @objc public var tableCellBackgroundColor: UIColor
    
    /// Show dial code
    @objc public var showDialCode: Bool
    
    /**
     Initializer
     */
    @objc public override init() {
        
        // Set default values
        self.selectedTitleFont = UIFont.systemFont(ofSize: 15.0)
        self.titleFont = UIFont.systemFont(ofSize: 15.0)
        self.emptySearchMessageFont = UIFont.systemFont(ofSize: 15.0)
        self.searchBarTintColor = UIColor.lightGray
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
        self.viewBackgroundColor = UIColor.white
        self.pickerLanguage = .en
        self.tableCellInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.tableCellCornerRaduis = 0.0
        self.tableCellBackgroundColor = UIColor.white
        self.navigationBarTitleTextAttributes = [:]
        self.showDialCode = true
    }
}
