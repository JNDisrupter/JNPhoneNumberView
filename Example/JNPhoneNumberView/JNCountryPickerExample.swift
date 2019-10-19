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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "JN Country Picker Example"
    }
    
    
    @IBAction private func didClickSelectCountryButton() {
        
        let configuration = JNCountryPickerConfiguration()
        configuration.pickerLanguage = .ar
        configuration.tableCellInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        configuration.viewBackgroundColor = UIColor.lightGray
        configuration.tableCellBackgroundColor = UIColor.white
        
        // Init
        let countryPickerViewController = JNCountryPickerViewController()
        countryPickerViewController.pickerConfiguration = configuration
        countryPickerViewController.delegate = self
        countryPickerViewController.dataSourceDelegate = self
        let nevigationController = UINavigationController(rootViewController: countryPickerViewController)
        self.present(nevigationController, animated: true, completion: nil)
    }
    
    /**
     Did Select Country
     - Parameter country: country as JNCountry.
     */
    func countryPickerViewController(didSelectCountry country: JNCountry) {
        
        self.selectedCountryInfoLabel.text = " Country Name: \(country.name) \n Country Dial Code: \(country.dialCode)  \n Country Code: \(country.code)"
    }
    
    func countryPickerViewControllerLoadCountryList(completion: ([JNCountry]) -> Void, errorCompletion: (NSError) -> Void) {
        errorCompletion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error"]))
    }
}
