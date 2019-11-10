//
//  JNCountryPickerViewController.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import Foundation
import UIKit

/// JN Country Picker View Controller
@objc public class JNCountryPickerViewController: UIViewController {
    
    /// Search Bar
    @IBOutlet private weak var searchBar: UISearchBar!
    
    /// Table view
    @IBOutlet private(set) weak var tableView: UITableView!
    
    /// selected country
    @objc public var selectedCountry: JNCountry?
    
    /// country list
    private var countryList: [JNCountry] = []
    
    /// View model
    private(set) var viewModel: JNCountryPickerViewModel!
    
    /// Picker Configuration
    @objc public var pickerConfiguration: JNCountryPickerConfiguration = JNCountryPickerConfiguration()
    
    /// Delegate
    @objc public weak var delegate: JNCountryPickerViewControllerDelegate?
    
    /// Data Source Delegate
    @objc public weak var dataSourceDelegate: JNCountryPickerViewControllerDataSourceDelegate?
    
    /// Refresh control
    private(set) var refreshControl: UIRefreshControl!
    
    /**
    Load View
     */
    public override func loadView() {
        
        // Create nib
        let nib = UINib(nibName: "JNCountryPickerViewController", bundle: Bundle(for: JNCountryPickerViewController.self))
        
        // container view
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        // Set view
        self.view = view
    }
    
    /**
     View Did Load
     */
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view background color
        self.view.backgroundColor = pickerConfiguration.viewBackgroundColor
        
        // Init Country Picker View Model
        self.viewModel = JNCountryPickerViewModel(pickerAttributes: self.pickerConfiguration)
        
        // Setup Search View
        self.setupSearchView()
        
        // Setup Navigation Bar
        self.setupNavigationBar()
        
        // Setup table view cell
        self.setupTableView()
        
        // Setup refresh control
        self.setupRefreshControl()
        
        // Setup Select Bar Button
        self.setupSelectBarButtonItem()
        
        // Setup Close Bar Button Item
        self.setupCloseBarButtonItem()
        
        // Load data
        self.loadData()
        
        // disable extend edges for ios 9.0, view goes under navigation bar
        self.edgesForExtendedLayout = []
    }
    
    /**
     View will appear
     */
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Show toolbar
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    /**
     View Will Disappear
     */
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Resign First Responder
        self.view.endEditing(true)
    }
    
    // MARK: Navigation Bar
    
    /**
     Setup Navigation Bar
     */
    private func setupNavigationBar() {
        
        // Set naviation bar colors
        self.navigationController?.navigationBar.barTintColor = self.pickerConfiguration.navigationBarColor
        self.navigationController?.navigationBar.tintColor = self.pickerConfiguration.naigationBarTintColor
        self.navigationController?.navigationBar.titleTextAttributes = self.pickerConfiguration.navigationBarTitleTextAttributes
        
        // set title
        self.title = self.pickerConfiguration.navigationBarTitle
    }
    
    
    // MARK: - Setup
    
    /**
     Setup Table View
     */
    private func setupTableView() {
        
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        
        // Register cells
        EmptyTableViewCell.registerCell(in: self.tableView)
        LoadingTableViewCell.registerCell(in: self.tableView)
        JNCountryPickerTableViewCell.registerCell(in: self.tableView)
    }
    
    /**
     Setup Search View
     */
    private func setupSearchView() {
        
        // Set search bar delegate
        self.searchBar.delegate = self
        self.searchBar.barTintColor = self.pickerConfiguration.searchBarTintColor
        self.searchBar.backgroundImage = UIImage() 
    }
    
    /**
     Setup Close Bar Button Item
     */
    private func setupCloseBarButtonItem() {
        
        // Init close image
        let closeImage = UIImage(named: "closeImageButton", in: Bundle(for: JNCountryPickerViewController.self), compatibleWith: nil)
        
        // Add close button as left bar button item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(self.didClickCloseBarButtonItem))
    }
    
    /**
     Setup Select Bar Button Item
     */
    private func setupSelectBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: self.pickerConfiguration.selectBarButtonTitle.capitalized, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.didClickSelectBarButton))
        self.enableSelectBarButton(isEnabled: false)
    }
    
    /**
     Setup refresh control
     */
    private func setupRefreshControl() {
        
        if #available(iOS 10.0, *) {
            
            // Set refresh control
            self.tableView.refreshControl = UIRefreshControl()
            self.refreshControl = self.tableView.refreshControl
        } else {
            
            // Init refresh control
            self.refreshControl = UIRefreshControl()
            self.tableView.addSubview(self.refreshControl)
        }
        
        // Customize refresh control
        self.refreshControl.tintColor = self.pickerConfiguration.loadingAcivityIndicatorColor
        self.refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: UIControl.Event.valueChanged)
        
        // Disable refresh control
        self.refreshControl.isEnabled = false
    }
    
    /**
     Enable Or Disable Bar Button
     - Parameter isEnabled: Enable Flag
     */
    @objc func enableSelectBarButton(isEnabled: Bool){
        self.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }
    
    // MARK: - Actions
    
    /**
     Did Click Select Bar Button
     */
    @objc private func didClickSelectBarButton() {
        
        // Get Selected country code from the view model
        guard let selectedItem = self.viewModel.getSelectedItem() else { return }
        
        // call delegate did select country code
        self.delegate?.countryPickerViewController(didSelectCountry: selectedItem)
        
        // Dismiss view controller
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /**
     Did Click Close Bar Button Item
     */
    @objc private func didClickCloseBarButtonItem() {
        
        // Dismiss view controller
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Request
    
    /**
     Load Local Countries
     */
    private func loadLocalCountries() {
        
        /// Load country code
        self.loadCountriesFromLocalFile { [weak self] (countryList) in
            
            /// weak self
            guard let weakSelf = self  else { return }
            
            // Country codes and reload data
            weakSelf.viewModel.setCountryList(countryList, selectedCountry: weakSelf.selectedCountry)
            weakSelf.tableView.reloadData()
            
            // Enable search bar
            self?.searchBar.isUserInteractionEnabled = true
        }
    }
    
    /**
     Load Data
     */
    private func loadData() {
        
        // Disbale search bar
        self.searchBar.isUserInteractionEnabled = false
        
        // Check if data source is available
        if let dataSourceDelegate = self.dataSourceDelegate {
            
            // Call delegate
            dataSourceDelegate.countryPickerViewControllerLoadCountryList(completion: { [weak self] countryList in
                
                // Check if empty
                if countryList.isEmpty {
                    
                    // Load Local countries
                    self?.loadLocalCountries()
                } else {
                    
                    // Set country code to view model
                    self?.viewModel.setCountryList(countryList, selectedCountry: self?.selectedCountry)
                    
                    // Reload table view
                    self?.tableView.reloadData()
                    
                    // Enable search bar
                    self?.searchBar.isUserInteractionEnabled = true
                }
                
                // End refreshing
                self?.refreshControl.endRefreshing()
                
                // Enable refresh control
                self?.refreshControl.removeFromSuperview()
                
            }) { [weak self] error in
                
                // Handle error
                self?.viewModel.handleLoadCountriesFailure(errorMessage: error.localizedDescription)
                
                // Reload table view
                self?.tableView.reloadData()
                
                // End refreshing
                self?.refreshControl.endRefreshing()
            }
        } else {
            
            // Load Local countries
            self.loadLocalCountries()
        }
    }
    
    // MARK: - Scroll view methods
    
    /**
     Scroll View Did Scroll
     */
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Check if draging
        if !scrollView.isDragging {
            return
        }
        
        // Resgin first responder
        self.searchBar.resignFirstResponder()
    }
    
    // MARK: - Refresh control
    
    /**
     Refresh Table View
     */
    @objc func refreshTableView(_ sender:AnyObject) {
        
        // Reload data
        self.loadData()
    }
}

/// JN Country Picker View Controller Delegate
@objc public protocol JNCountryPickerViewControllerDelegate: NSObjectProtocol {
    
    /**
     Did Select Country
     - Parameter country: country as JNCountry.
     */
    @objc func countryPickerViewController(didSelectCountry country: JNCountry)
}

/// JN Country Picker View Controller Delegate
@objc public protocol JNCountryPickerViewControllerDataSourceDelegate: NSObjectProtocol {
    
    /**
     Load country list
     - Parameter completion: completion block
     - Parameter errorCompletion: errorCompletion
     */
    @objc func countryPickerViewControllerLoadCountryList(completion: @escaping ([JNCountry]) -> Void, errorCompletion: @escaping (NSError) -> Void)
}
