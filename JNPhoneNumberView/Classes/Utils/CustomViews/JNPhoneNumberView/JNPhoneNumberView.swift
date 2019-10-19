//
//  PhoneNumberView.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 07/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

/// JN Phone Number View
public class JNPhoneNumberView: UIView, UITextFieldDelegate {
    
    /// Country Code Button
    @IBOutlet private weak var countryCodeButton: UIButton!
    
    /// Text View
    @IBOutlet private weak var textField: UITextField!
    
    /// Delegate
    @objc public weak var delegate: JNPhoneNumberViewDelegate?
    
    /// Dart source delegate
    @objc public weak var dataSourceDelegate: JNPhoneNumberViewDataSourceDelegate?
    
    /// Default country
    private var selectedCountry: JNCountry!
    
    /// Left toolbar bar button item
    private var leftToolbarBarButtonItem: UIBarButtonItem!
    
    /// Configuration
    private var configuration: JNPhoneNumberViewConfiguration! {
        didSet {
            
            // setup views
            self.setupTextField()
            self.setupCountyCodeButton()
            self.leftToolbarBarButtonItem.title = self.configuration.leftToolBarBarButtonItemTitle
        }
    }
    
    /**
     Initializer
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Common init
        self.commonInit()
    }
    
    /**
     Initializer
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Common init
        self.commonInit()
    }
    
    /**
     Common Init
     */
    private func commonInit() {
        
        // Call setup methods
        self.setupXib()
        
        // default country code
        if let countryCode = (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String {
            
            // Set selected country
            self.selectedCountry = CountryUtil.generateDialCode(for: countryCode)
        } else {
            
            // Set selected country as US
            self.selectedCountry = CountryUtil.generateDialCode(for: "US")
        }
        
        // Setup toolbar
        self.setupToolbar()
        
        // init attributes
        self.configuration = JNPhoneNumberViewConfiguration()
    }
    
    // MARK: - Setters
    
    /**
     Set default country code
     - Parameter defaultCountryCode: default country code as string
     */
    @objc public func setDefaultCountryCode(_ defaultCountryCode: String) {
        
        // Set selected country
        self.selectedCountry = CountryUtil.generateDialCode(for: defaultCountryCode)
        
        // Setup country code button
        self.setupCountyCodeButton()
    }
    
    /**
     Set view configuration
     - Parameters configuration: view configuration as JNPhoneNumberViewConfiguration
     */
    @objc public func setViewConfiguration(_ configuration: JNPhoneNumberViewConfiguration) {
        
        // Set configuration
        self.configuration = configuration
    }
    
    /**
     Set Phone Number
     - Parameter phoneNumber: phone number as string
     */
    @objc public func setPhoneNumber(_ phoneNumber: String) {
        
        // Modified phone number
        var modifiedPhoneNumber = phoneNumber
        
        // Check prefix
        if modifiedPhoneNumber.prefix(2) == "00" {
            
            // remove zeros prefix
            modifiedPhoneNumber.removeSubrange(modifiedPhoneNumber.startIndex...modifiedPhoneNumber.index(modifiedPhoneNumber.startIndex, offsetBy: 1))
            
            modifiedPhoneNumber = "+"+modifiedPhoneNumber
        }
        
        // Check if the first digit not equal '+'
        if modifiedPhoneNumber.first == "+" {
            
            // Parsed phone number
            if let parsedPhoneNumber = PhoneNumberUtil.parsePhoneNumber(phoneNumber, defaultRegion: self.selectedCountry.code) {
                
                // Adjust selected country
                self.selectedCountry = CountryUtil.generateCountryCode(for: parsedPhoneNumber.countryCode.description)
                
                // Setup country code button
                self.setupCountyCodeButton()
                
                // Set phone number
                self.textField.text = parsedPhoneNumber.nationalNumber.description
            } else {
                
                // remove the "+" and use it as local number
                modifiedPhoneNumber.removeFirst()
                
                // Set phone number
                self.textField.text = modifiedPhoneNumber
            }
        } else {
            
            // Set phone number
            self.textField.text = modifiedPhoneNumber
        }
    }
    
    // MARK: - Setup
    
    /**
     Setup default country code
     */
    private func setupCountyCodeButton() {
        
        // Init flag
        if let countryCode = self.selectedCountry {
            
            // Init flag
            let flag = CountryUtil.generateFlag(from: countryCode.code)
            
            // Set button title
            self.countryCodeButton.setAttributedTitle(NSAttributedString(string: flag + " " + countryCode.dialCode , attributes: [NSAttributedString.Key.font : self.configuration.countryDialCodeTitleFont, NSAttributedString.Key.foregroundColor : self.configuration.countryDialCodeTitleColor]), for: .normal)
        }
    }
    
    /**
     Setup Text Field
     */
    private func setupTextField() {
        
        // Set delegate
        self.textField.delegate = self
        
        // set keyboard type
        self.textField.keyboardType = .numberPad
        
        // Set font
        self.textField.font = self.configuration.phoneNumberTitleFont
        
        // Set color
        self.textField.textColor = self.configuration.phoneNumberTitleColor
        
        // Set place holder
        self.textField.placeholder = self.configuration.phoneNumberPlaceHolder
    }
    
    /**
     Setup XIB
     */
    private func setupXib() {
        
        // Create nib
        let nib = UINib(nibName: "JNPhoneNumberView", bundle: Bundle(for: JNPhoneNumberView.self))
        
        // container view
        let containerView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        // Add container view as subview
        self.addSubview(containerView)
    }
    
    // MARK: - Toolbar and its action
    
    /**
     Setup Toolbar
     */
    private func setupToolbar() {
        
        // Init ToolBar
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.tintColor = UIColor.black
        
        // Adding Done Button ToolBar
        self.leftToolbarBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.didClickDone))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        toolbar.items = [spaceButton, self.leftToolbarBarButtonItem]
        toolbar.sizeToFit()
        
        self.textField.inputAccessoryView = toolbar
    }
    
    /**
     Did Click Done
     */
    @objc func didClickDone() {
        
        // Call delegate
        self.textField.endEditing(true)
        
        self.textField.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    /**
     Did Click Area Code Selection Button
     */
    @IBAction private func didClickAreaCodeSelectionButton(_ sender: Any) {
        
        // did click area code selection button
        if let delegate = self.delegate {
            
            /// Init countries picker view controller
            let countriesPickerViewController = JNCountryPickerViewController()
            
            // Set picker attributes
            countriesPickerViewController.pickerConfiguration = delegate.phoneNumberViewGetCountryPickerAttributes()
            
            // Set data source delegate
            countriesPickerViewController.dataSourceDelegate = self
            
            // Set delegate
            countriesPickerViewController.delegate = self
            
            // Set selected country
            countriesPickerViewController.selectedCountry = self.selectedCountry
            
            // Presenter view controller
            let presenterViewController = delegate.phoneNumberViewGetPresenterViewController()
            
            // Init navigation controller and present it
            let navigationController = UINavigationController(rootViewController: countriesPickerViewController)
            presenterViewController.present(navigationController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    /**
     Text field should return
     */
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    /**
     Text field should Change Characters In
     */
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Make sure just numbers is typed when KeyboardType is numberPad
        if self.textField.keyboardType == UIKeyboardType.numberPad {
            
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
            
        } else if string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty && (textField.text?.isEmpty)! {
            return false
        } else{
            return true
        }
    }
    
    /**
     Did end editing
     */
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Call delegate
        self.delegate?.phoneNumberView(didEndEditing: self.getPhoneNumber(), isValidPhoneNumber: self.isValidPhoneNumber())
    }
    
    /**
     Text Field Did Change Text
     */
    @IBAction func textFieldDidChangeText(_ sender: Any) {
        
        // Call delegate
        self.delegate?.phoneNumberView(didChangeText: self.getPhoneNumber())
    }
    
    // MARK: - Validation
    
    /**
     Is Valid Phone Number
     - Returns: bool falg to indicate if its valid phone number
     */
    func isValidPhoneNumber() -> Bool {
        
        // Is phone number valid
        let isValidPhoneNumber = PhoneNumberUtil.isPhoneNumberValid(phoneNumber: self.getPhoneNumber(), defaultRegion: self.selectedCountry.dialCode)
        
        return isValidPhoneNumber
    }
    
    // MARK: - Getters
    
    /**
     Get Phone Number
     - Returns: phoneNumber as string
     */
    func getPhoneNumber() -> String {
        
        // Return phone number
        return self.selectedCountry.dialCode+(self.textField.text ?? "")
    }
}

/// Country Code Picker Delegate
extension JNPhoneNumberView: JNCountryPickerViewControllerDelegate {
    
    /**
     Did Select Country Code
     - Parameter countryCode: CountryCode.
     */
    public func countryPickerViewController(didSelectCountry countryCode: JNCountry) {
        
        // Set selected country
        self.selectedCountry = countryCode
        
        // Setup country code button
        self.setupCountyCodeButton()
    }
}

/// Country Code Data Source Delegate
extension JNPhoneNumberView: JNCountryPickerViewControllerDataSourceDelegate {
    
    /**
     Get country code list
     - Parameter completion: completion block
     - Parameter errorCompletion
     */
    public func countryPickerViewControllerLoadCountryList(completion: ([JNCountry]) -> Void, errorCompletion: (NSError) -> Void) {
        
        // Data source delegate
        if let dataSourceDelegate = self.dataSourceDelegate {
            
            // Call phone view data source delegate
            dataSourceDelegate.countryPickerViewControllerLoadCountryList(completion: { countryList in
                
                // Call completion
                completion(countryList)
                
            }) { error in
                
                // Call error completion
                errorCompletion(error)
            }
        } else {
            
            // Call completion with empty list
            completion([])
        }
    }
}

/// JN Phone Number View Delegate
@objc public protocol JNPhoneNumberViewDelegate: NSObjectProtocol {
    
    /**
     Get presenter view controller
     - Returns: presenter view controller
     */
    func phoneNumberViewGetPresenterViewController() -> UIViewController
    
    /**
     Get country picker configuration
     */
    func phoneNumberViewGetCountryPickerAttributes() -> JNCountryPickerConfiguration
    
    /**
     Did change text
     - Parameter text: New text.
     - Parameter cellIndex: Cell index
     */
    func phoneNumberView(didChangeText text: String)
    
    /**
     Did end editing
     - Parameter text: New text.
     - Parameter isValidPhoneNumber: Is valid phone number flag as bool
     */
    func phoneNumberView(didEndEditing text: String, isValidPhoneNumber: Bool)
}

/// JN Phone Number View Delegate
@objc public protocol JNPhoneNumberViewDataSourceDelegate: NSObjectProtocol {
    
    /**
     Load country list
     - Parameter completion: completion block
     - Parameter errorCompletion: errorCompletion
     */
    @objc func countryPickerViewControllerLoadCountryList(completion: ([JNCountry]) -> Void, errorCompletion: (NSError) -> Void)
}
