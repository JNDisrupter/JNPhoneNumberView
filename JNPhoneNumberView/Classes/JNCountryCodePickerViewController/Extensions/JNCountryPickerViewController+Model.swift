//
//  JNCountryPickerViewController+Model.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import Foundation

/// Model
extension JNCountryPickerViewController {
    
    /**
     Get Countries From Local File
     - Parameter completion: reading country code from file completion
     */
    func loadCountriesFromLocalFile(completion: @escaping ([JNCountry]) -> Void) {
        
        DispatchQueue.main.async {
            
            // Countries lisr
            var countriesList = [JNCountry]()
            
            // bundle
            let bundle = Bundle(for: JNCountryPickerViewController.self)
            
            // get path
            let file = bundle.path(forResource: self.pickerConfiguration.pickerLanguage.getFileName(), ofType: "json")
        
            do {
                let data =  try Data(contentsOf: URL(fileURLWithPath: file!))
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [NSDictionary] {
                    
                    for item in jsonResult {
                        countriesList.append(Country(representation: item))
                    }
                }
            } catch let error{
                print(error.localizedDescription)
            }
            
            // Call completion
            completion(countriesList)
        }
    }
}
