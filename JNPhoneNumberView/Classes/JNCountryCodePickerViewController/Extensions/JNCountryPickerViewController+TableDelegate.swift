//
//  JNCountryPickerViewController+TableDelegate.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

// Table Delegate
extension JNCountryPickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    /**
     Number of rows
     */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(inSection: section)
    }
    
    /**
     Cell for row
     */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Representable
        let representable = self.viewModel.representableForRow(at: indexPath)
        
        // Country Picker Cell representable
        if let cellRepresentable = representable as? JNCountryPickerTableViewCellRepresentable {
            
            // Dequeue cell
            let cell = tableView.dequeueReusableCell(withIdentifier: JNCountryPickerTableViewCell.getReuseIdentifier(), for: indexPath) as! JNCountryPickerTableViewCell
            
            // Setup cell
            cell.setup(representable: cellRepresentable, containerViewInsets: self.pickerConfiguration.tableCellInsets, cornerRadious: self.pickerConfiguration.tableCellCornerRaduis, containerViewBackgroundColor: self.pickerConfiguration.tableCellBackgroundColor)
            
            return cell
        }
        
        // General Resource Cell representable
        else if let generalResourceCellRepresentable = representable as? GeneralResourceTableViewCellRepresentable {
            
            // Check type
            if generalResourceCellRepresentable.type == .loading {
                
                // Dequeue loading cell
                let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.getReuseIdentifier(), for: indexPath) as! LoadingTableViewCell
                
                // Setup cell
                cell.setup(activityIndicatorColor: self.pickerConfiguration.loadingAcivityIndicatorColor)
                
                return cell
            }
                
            // Empty search
            else if generalResourceCellRepresentable.type == .emptyDataWithImage {
                
                // Dequeue loading cell
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.getReuseIdentifier(), for: indexPath) as! EmptyTableViewCell
                
                // Setup cell
                cell.setup(attributedString: generalResourceCellRepresentable.text, image: UIImage(named: generalResourceCellRepresentable.imageName))
                
                return cell
            }
            
            // Failure
            else if generalResourceCellRepresentable.type == .emptyDataOnly {
                
                // Dequeue loading cell
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.getReuseIdentifier(), for: indexPath) as! EmptyTableViewCell
                
                // Setup cell
                cell.setup(attributedString: generalResourceCellRepresentable.text)
                
                return cell
            }
        }
        
        // Default
        return UITableViewCell()
    }
    
    /**
     Height for row
     */
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath, tableView: tableView)
    }
    
    /**
     Estimated height for row
     */
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Height
        let height = self.viewModel.heightForRow(at: indexPath, tableView: tableView)
        
        // Check if automatic height
        if height == UITableView.automaticDimension {
            return 70.0
        }
        
        return height
    }
    
    /**
     Did Select Row At IndexPath
     */
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Check if representable is not general resource
        guard self.viewModel.representableForRow(at: indexPath) is JNCountryPickerTableViewCellRepresentable else { return }
        
        // Set Item Selected
        self.viewModel.setSelected(indexPath: indexPath)
        
        // Enable Select Bar Button
        self.enableSelectBarButton(isEnabled: true)
        
        // Reload TableView
        self.tableView.reloadData()
    }
}
