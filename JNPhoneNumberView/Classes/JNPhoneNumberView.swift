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
    
    /// Country code label
    @IBOutlet private weak var countryCodeLabel: UILabel!
    
    /// flag label
    @IBOutlet private weak var flagLabel: UILabel!
    
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
            self.setupCountyLabels()
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
     Resgin first responder
     */
    public override func resignFirstResponder() -> Bool {
        return self.textField.resignFirstResponder()
    }
    
    /**
     Become first responder
     */
    public override func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
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
            self.selectedCountry = JNCountryUtil.generateDialCode(for: countryCode)
        } else {
            
            // Set selected country as US
            self.selectedCountry = JNCountryUtil.generateDialCode(for: "US")
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
        
        // Do nothing if the default region code is empty
        guard !defaultCountryCode.isEmpty else {
            return
        }
        
        // Set selected country
        if let country = JNCountryUtil.generateDialCode(for: defaultCountryCode) {
            self.selectedCountry = country
        }
        
        // Setup country code button
        self.setupCountyLabels()
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
        
        // Substring to allowed maximum index
        if modifiedPhoneNumber.count > self.configuration.maximumNumbrOfDigits {
            let index = modifiedPhoneNumber.index(modifiedPhoneNumber.startIndex, offsetBy: self.configuration.maximumNumbrOfDigits)
            let validSubString = modifiedPhoneNumber.prefix(upTo: index)
            modifiedPhoneNumber = String(validSubString)
        }
        
        // Check prefix
        if modifiedPhoneNumber.prefix(2) == "00" {
            
            // remove zeros prefix
            modifiedPhoneNumber.removeSubrange(modifiedPhoneNumber.startIndex...modifiedPhoneNumber.index(modifiedPhoneNumber.startIndex, offsetBy: 1))
            
            modifiedPhoneNumber = "+" + modifiedPhoneNumber
        }
        
        // Check if the first digit not equal '+'
        if modifiedPhoneNumber.first == "+" {
            
            // Parsed phone number
            if let parsedPhoneNumber = JNPhoneNumberUtil.parsePhoneNumber(phoneNumber, defaultRegion: self.selectedCountry.code) {
                
                // Adjust selected country
                self.selectedCountry = JNCountryUtil.generateCountryCode(for: parsedPhoneNumber)
                
                // Setup country code button
                self.setupCountyLabels()
                
                // Set phone number
                self.textField.text = parsedPhoneNumber.nationalNumber.uint64Value >= 0 ? parsedPhoneNumber.nationalNumber.description : ""
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
    
    /**
     Set national number
     - Parameter nationalNumber: national number as string
     - Parameter preferredRegionCode: region code as string
     */
    @objc public func setPhoneNumber(nationalNumber: String, preferredRegionCode: String) {
        var nationalNumber = nationalNumber
        
        // Substring to allowed maximum index
        if nationalNumber.count > self.configuration.maximumNumbrOfDigits {
            let index = nationalNumber.index(nationalNumber.startIndex, offsetBy: self.configuration.maximumNumbrOfDigits)
            let validSubString = nationalNumber.prefix(upTo: index)
            nationalNumber = String(validSubString)
        }
        
        // Set phone number
        if let nationalNumber = UInt64(nationalNumber) {
            self.textField.text = nationalNumber.description
        } else {
            self.textField.text = nationalNumber
        }
        
        // Set default country from code
        self.setDefaultCountryCode(preferredRegionCode)
    }
    
    // MARK: - Setup
    
    /**
     Setup default country Labels
     */
    private func setupCountyLabels() {
        
        // Init flag
        if let countryCode = self.selectedCountry {
            
            // Init flag
            let flag = JNCountryUtil.generateFlag(from: countryCode.code)
            
            // Build flag attributes
            var flagAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : self.configuration.countryDialCodeTitleFont, NSAttributedString.Key.foregroundColor : self.configuration.countryDialCodeTitleColor]
            
            // Find font and adjust the font size
            if let font = flagAttributes[NSAttributedString.Key.font] as? UIFont {
                
                // new font
                let newFont = font.withSize(font.pointSize + 12.0)
                
                // set font with new size
                flagAttributes[NSAttributedString.Key.font] = newFont
            }
            
            // Init flag attributed string
            let flagAttributedString = NSMutableAttributedString(string: flag, attributes: flagAttributes)
            
            let countryCodeAttributedString = NSMutableAttributedString(string: countryCode.dialCode , attributes: [NSAttributedString.Key.font : self.configuration.phoneNumberTitleFont, NSAttributedString.Key.foregroundColor : self.configuration.countryDialCodeTitleColor])
            
            // Set titles
            self.flagLabel.attributedText = flagAttributedString
            self.countryCodeLabel.attributedText = countryCodeAttributedString
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
        self.textField.attributedPlaceholder = self.configuration.phoneNumberAttributedPlaceHolder
    }
    
    /**
     Setup XIB
     */
    private func setupXib() {
        
        // Create nib
        let nib = UINib(nibName: "JNPhoneNumberView", bundle: Bundle(for: JNPhoneNumberView.self))
        
        // View
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            
            // Add subview
            self.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
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
            countriesPickerViewController.pickerConfiguration = delegate.phoneNumberView(getCountryPickerAttributesFor: self)
            
            // Set data source delegate
            countriesPickerViewController.dataSourceDelegate = self
            
            // Set delegate
            countriesPickerViewController.delegate = self
            
            // Set selected country
            countriesPickerViewController.selectedCountry = self.selectedCountry
            
            // Presenter view controller
            let presenterViewController = delegate.phoneNumberView(getPresenterViewControllerFor: self)
            
            // Init navigation controller and present it
            let navigationController = UINavigationController(rootViewController: countriesPickerViewController)
            navigationController.navigationBar.isTranslucent = false
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
            if allowedCharacters.isSuperset(of: characterSet) {
                
                // Modified phone number
                if let textFieldString = textField.text {
                    
                    // Trying to delete
                    if string.isEmpty {
                        return true
                    }
                    
                    // Trying to add
                    return (textFieldString.count + string.count) < self.configuration.maximumNumbrOfDigits
                } else {
                    return string.count < self.configuration.maximumNumbrOfDigits
                }
            }
            
            return false
        } else if string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty && (textField.text?.isEmpty)! {
            return false
        } else {
            return true
        }
    }
    
    /**
     Did end editing
     */
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Call delegate
        self.delegate?.phoneNumberView(didEndEditing: (self.textField.text ?? ""), country: self.selectedCountry, isValidPhoneNumber: self.isValidPhoneNumber(), forPhoneNumberView: self)
    }
    
    /**
     Text Field Did Change Text
     */
    @IBAction func textFieldDidChangeText(_ sender: Any) {
        
        // Call delegate
        self.delegate?.phoneNumberView(didChangeText: (self.textField.text ?? ""), country: self.selectedCountry, forPhoneNumberView: self)
    }
    
    // MARK: - Validation
    
    /**
     Is Valid Phone Number
     - Returns: bool falg to indicate if its valid phone number
     */
    @objc public func isValidPhoneNumber() -> Bool {
        
        // Is phone number valid
        let isValidPhoneNumber = JNPhoneNumberUtil.isPhoneNumberValid(phoneNumber: self.getPhoneNumber(), defaultRegion: self.selectedCountry.code)
        
        return isValidPhoneNumber
    }
    
    // MARK: - Getters
    
    /**
     Get Phone Number
     - Returns: phoneNumber as string
     */
    @objc public func getPhoneNumber() -> String {
        
        // Return phone number
        return self.selectedCountry.dialCode+(self.textField.text ?? "")
    }
    
    /**
     Get National Phone Number
     - Returns: national phone Number as string
     */
    @objc public func getNationalPhoneNumber() -> String {
        
        // Return phone number
        return self.textField.text ?? ""
    }
    
    /**
     Get dial code
     - Returns: dial code as string
     */
    @objc public func getDialCode() -> String {
        
        // Return dial code
        return self.selectedCountry.dialCode
    }
    
    /**
     Get selected country
     - Returns: country as JNCountry
     */
    @objc public func getSelectedCountry() -> JNCountry {
        
        // Return dial code
        return self.selectedCountry
    }
}

/// Country Code Picker Delegate
extension JNPhoneNumberView: JNCountryPickerViewControllerDelegate {
    
    /**
     Did Select Country
     - Parameter controller: JN Country Picker ViewController
     - Parameter country: country as JNCountry.
     */
    public func countryPickerViewController(_ controller: JNCountryPickerViewController, didSelectCountry country: JNCountry) {
        
        // Set selected country
        self.selectedCountry = country
        
        // Setup country code button
        self.setupCountyLabels()
        
        // Call delegate
        self.delegate?.phoneNumberView(countryDidChanged: country, isValidPhoneNumber: self.isValidPhoneNumber(), forPhoneNumberView: self)
    }
}

/// Country Code Data Source Delegate
extension JNPhoneNumberView: JNCountryPickerViewControllerDataSourceDelegate {
    
    /**
     Load country list
     - Parameter controller: JN Country Picker ViewController
     - Parameter completion: completion block
     - Parameter errorCompletion: errorCompletion
     */
    public func countryPickerViewControllerLoadCountryList(_ controller: JNCountryPickerViewController, completion: @escaping ([JNCountry]) -> Void, errorCompletion: @escaping (NSError) -> Void) {
        
        // Data source delegate
        if let dataSourceDelegate = self.dataSourceDelegate {
            
            // Call phone view data source delegate
            dataSourceDelegate.countryPickerViewControllerLoadCountryList(self, completion: { countryList in
                
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
     - Parameter phoneNumberView: Phone number view
     - Returns: presenter view controller
     */
    func phoneNumberView(getPresenterViewControllerFor phoneNumberView: JNPhoneNumberView) -> UIViewController
    
    /**
     Get country picker configuration
     - Parameter phoneNumberView: Phone number view
     */
    func phoneNumberView(getCountryPickerAttributesFor phoneNumberView: JNPhoneNumberView) -> JNCountryPickerConfiguration
    
    /**
     Did change text
     - Parameter nationalNumber: National phone number
     - Parameter country: Number country info
     - Parameter phoneNumberView: Phone number view
     */
    func phoneNumberView(didChangeText nationalNumber: String, country: JNCountry, forPhoneNumberView phoneNumberView: JNPhoneNumberView)
    
    /**
     Did end editing
     - Parameter nationalNumber: National phone number
     - Parameter country: Number country info
     - Parameter isValidPhoneNumber:  Is valid phone number flag as bool
     - Parameter phoneNumberView: Phone number view
     */
    func phoneNumberView(didEndEditing nationalNumber: String, country: JNCountry, isValidPhoneNumber: Bool, forPhoneNumberView phoneNumberView: JNPhoneNumberView)
    
    /**
     Country Did Changed
     - Parameter country: New Selected Country
     - Parameter isValidPhoneNumber: Is valid phone number flag as bool
     - Parameter phoneNumberView: Phone number view
     */
    func phoneNumberView(countryDidChanged country: JNCountry, isValidPhoneNumber: Bool, forPhoneNumberView phoneNumberView: JNPhoneNumberView)
}

/// JN Phone Number View Delegate
@objc public protocol JNPhoneNumberViewDataSourceDelegate: NSObjectProtocol {
    
    /**
     Load country list
     - Parameter phoneNumberView: Phone number view
     - Parameter completion: completion block
     - Parameter errorCompletion: errorCompletion
     */
    @objc func countryPickerViewControllerLoadCountryList(_ phoneNumberView: JNPhoneNumberView, completion: @escaping ([JNCountry]) -> Void, errorCompletion: @escaping (NSError) -> Void)
}
