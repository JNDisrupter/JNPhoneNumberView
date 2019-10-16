//
//  JNCountryPickerViewModel.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

// JN Country Code Picker View Model
class JNCountryPickerViewModel {
    
    /// country Representables
    private var countryRepresentables: [TableViewCellRepresentable]
    
    /// Filtered Country Representables
    private var filteredCountryRepresentables: [TableViewCellRepresentable]
    
    /// Selected country
    private var selectedCountry: JNCountry?
    
    /// Search Text
    private var searchText: String = ""
    
    /// Country List
    private var countryList: [JNCountry]!
    
    /// Picker attributes
    private var pickerAttributes: JNCountryPickerConfiguration
    
    /**
     Initializer
     - Parameter pickerAttributes: Country Code Picker Attributes
     - Parameter selectedCountry: selected country
     */
    init(pickerAttributes: JNCountryPickerConfiguration, selectedCountry: JNCountry?) {
        
        // Set selected country
        self.selectedCountry = selectedCountry
        
        // Set picker attributes
        self.pickerAttributes = pickerAttributes
        
        // Set default values
        self.countryRepresentables = []
        self.filteredCountryRepresentables = []
        
        // Add loading GeneralResourceViewRepresentable
        let loadingGeneralResource = GeneralResource.getLoadingGeneralResource()
        self.countryRepresentables.append(GeneralResourceTableViewCellRepresentable(generalResource: loadingGeneralResource))
    }
    
    // MARK: - Setters
    
    /**
     Set country list
     - Parameters countryLisr: Country list as list of JNCountry
     */
    func setCountryList(_ countryList: [JNCountry]) {
        
        // Set country code
        self.countryList = countryList
        
        // Build representables
        self.buildRepresentables()
    }
    
    // MARK: - Table view methods
    
    /**
     Get number of rows in sections.
     - Parameter section: Section number as Int.
     - Returns: Number of rows in section as Int.
     */
    func numberOfRows(inSection section: Int) -> Int {
        
        // Check mode if search or normal
        if self.searchText.isEmpty {
            return self.countryRepresentables.count
        } else {
            return self.filteredCountryRepresentables.count
        }
    }
    
    /**
     Get cell representable at indexPath.
     - Parameter indexPath: Index path.
     - Returns: Cell representable as tableView cell representable.
     */
    func representableForRow(at indexPath: IndexPath) -> TableViewCellRepresentable? {
        
        // Check mode if search or normal
        if self.searchText.isEmpty {
            return self.countryRepresentables[indexPath.row]
        } else {
            return self.filteredCountryRepresentables[indexPath.row]
        }
    }
    
    /**
     Get height of row at indexPath.
     - Parameter indexPath: Index path.
     - Parameter tableView: Table View.
     - Returns: height of row at indexPath as CGFloat.
     */
    func heightForRow(at indexPath: IndexPath, tableView: UITableView ) -> CGFloat {
        
        // Check if general resource representable
        if let generalRepresentable = self.representableForRow(at: indexPath) as? GeneralResourceTableViewCellRepresentable {
            
            if generalRepresentable.type == GeneralResourceType.loading {
                
                return LoadingTableViewCell.getCellHeight(in: tableView)
            } else {
                return EmptyTableViewCell.getCellHeight(in: tableView)
            }
        } else {
            return self.representableForRow(at: indexPath)?.cellHeight ?? 0.0
        }
    }
    
    // MARK: - Setters
    
    /**
     Set Selected pickable
     - Parameter indexPath: Selected pickable index
     */
    func setSelected(indexPath: IndexPath) {
        
        // Get Item Representable at index path
        if let itemRepresentable = self.representableForRow(at: indexPath) {
            
            guard itemRepresentable.itemDataIndex >= 0 ,itemRepresentable.itemDataIndex < self.countryList.count else { return }
            
            // Set selected item
            self.selectedCountry = self.countryList[itemRepresentable.itemDataIndex]
            
            // Build representables
            self.buildRepresentables()
        }
    }
    
    /**
     Get Selected Item
     - Returns: Selected country
     */
    func getSelectedItem() -> JNCountry? {
        return self.selectedCountry
    }
    
    // MARK: - Build Representables
    
    /**
     Build Representables
     */
    private func buildRepresentables() {
        
        // Remove all item
        self.countryRepresentables.removeAll()

        for (index, item) in self.countryList.enumerated() {
            
            // Is Selected
            let isSelected = item.code == (self.selectedCountry?.code ?? "")
            
            // Check if selected
            if isSelected {
                self.selectedCountry = item
            }
            
            // Title
            let title = item.name + " ( " + item.dialCode + " )"
        
            
            // Init representable
            let countryRepresentable = JNCountryPickerTableViewCellRepresentable(flag: CountryUtil.generateFlag(from: item.code),title: title, isSelected: isSelected,
                                                                               
                                                                               selectedCountryNameAttributes:
                [NSAttributedString.Key.foregroundColor : self.pickerAttributes.selectedTitleColor, NSAttributedString.Key.font : self.pickerAttributes.selectedTitleFont]
                , normalCountryNameAttributes:
                [NSAttributedString.Key.foregroundColor : self.pickerAttributes.selectedTitleColor, NSAttributedString.Key.font : self.pickerAttributes.selectedTitleFont])
            
            countryRepresentable.itemDataIndex = index
            
            // Append picker Representable
            self.countryRepresentables.append(countryRepresentable)
        }
        
        // Check if search text not empty (user is searching) call the fitler content again to update the filtered representables with the new selection
        if !searchText.isEmpty {
            self.filterContent(text: self.searchText)
        }
    }
    
    // MARK: - General resource
    
    /**
     Get Empty Search Result General Resource
     */
    private func getEmptySearchResultGeneralResource() -> GeneralResource {
        
        // Init Empty Search Result General Resource
        let generalResource = GeneralResource()
        generalResource.type = GeneralResourceType.emptyDataWithImage
        generalResource.displayText = self.pickerAttributes.emptySearchMessage
        generalResource.displayImageName = "EmptySearchResult"
        
        return generalResource
    }
    
    // MARK: - Search
    
    /**
     Filter Representables
     - Parameter text: Search text
     */
    func filterContent(text: String){
        
        // Set serach text
        self.searchText = text
        
        // Trim search text
        let searchText = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        // Get filtered list
        if !searchText.isEmpty, let countryRepresentables = self.countryRepresentables as? [JNCountryPickerTableViewCellRepresentable] {
            
            let filteredList = countryRepresentables.filter({
                return $0.countryNameAttributedString.string.lowercased().contains(self.searchText.lowercased())
            })
            self.filteredCountryRepresentables = filteredList
        }
        
        // check if the filtered list is empty , add the add the empty general resource
        if self.filteredCountryRepresentables.isEmpty {
            self.filteredCountryRepresentables.append(GeneralResourceTableViewCellRepresentable(generalResource: self.getEmptySearchResultGeneralResource()))
        }
    }
}
