//
//  JNCountryPickerExample.swift
//  JNPhoneNumberView_Example
//
//  Created by Hamzawy Khanfar on 10/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import JNPhoneNumberView

class JNCountryPickerExample: UIViewController, JNCountryPickerViewControllerDelegate, JNCountryPickerViewControllerDataSourceDelegate  {

    
    @IBOutlet private weak var selectedCountryInfoLabel: UILabel!
   
    /// selected country
    var selectedCountry: JNCountry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "JN Country Picker Example"
    }
    
    
    @IBAction private func didClickSelectCountryButton() {
        
        let configuration = JNCountryPickerConfiguration()
        configuration.pickerLanguage = .en
        configuration.tableCellInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        configuration.tableCellCornerRaduis = 5.0
        configuration.viewBackgroundColor = UIColor.lightGray
        configuration.tableCellBackgroundColor = UIColor.white
        
        // Init
        let countryPickerViewController = JNCountryPickerViewController()
        countryPickerViewController.pickerConfiguration = configuration
        countryPickerViewController.selectedCountry = self.selectedCountry
        countryPickerViewController.delegate = self
        countryPickerViewController.dataSourceDelegate = self
        let nevigationController = UINavigationController(rootViewController: countryPickerViewController)
        self.present(nevigationController, animated: true, completion: nil)
    }
    
    /**
     Did Select Country
     - Parameter controller: JN Country Picker ViewController
     - Parameter country: country as JNCountry.
     */
     func countryPickerViewController(_ controller: JNCountryPickerViewController, didSelectCountry country: JNCountry) {
        
        // update Selected Country
        self.selectedCountry = country
        
        self.selectedCountryInfoLabel.text = " Country Name: \(country.name) \n Country Dial Code: \(country.dialCode)  \n Country Code: \(country.code)"
    }
    
    /**
     Load country list
     - Parameter controller: JN Country Picker ViewController
     - Parameter completion: completion block
     - Parameter errorCompletion: errorCompletion
     */
    func countryPickerViewControllerLoadCountryList(_ controller: JNCountryPickerViewController, completion: @escaping ([JNCountry]) -> Void, errorCompletion: @escaping (NSError) -> Void) {
        completion([])
    }
}
