//
//  JNCountryPickerViewController+UISearchBarDelegate.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

// MARK: - UISearchBarDelegate
extension JNCountryPickerViewController: UISearchBarDelegate {
    
    /**
     Text did changed
     */
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Filter with search text
        self.viewModel.filterContent(text: searchText)
        
        // Reload data after filtering
        self.tableView.reloadData()
    }
    
    /**
     Search Button clicked
     */
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // End searching and hide keyboard
        searchBar.resignFirstResponder()
    }
}
