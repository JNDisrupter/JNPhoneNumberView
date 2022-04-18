# JNPhoneNumberView

[![CI Status](https://img.shields.io/travis/hamzakhanfar/JNPhoneNumberView.svg?style=flat)](https://travis-ci.org/hamzakhanfar/JNPhoneNumberView)
[![Version](https://img.shields.io/cocoapods/v/JNPhoneNumberView.svg?style=flat)](https://cocoapods.org/pods/JNPhoneNumberView)
[![License](https://img.shields.io/cocoapods/l/JNPhoneNumberView.svg?style=flat)](https://cocoapods.org/pods/JNPhoneNumberView)
[![Platform](https://img.shields.io/cocoapods/p/JNPhoneNumberView.svg?style=flat)](https://cocoapods.org/pods/JNPhoneNumberView)

## Requirements

- iOS 9.0+ / macOS 10.10+
- Xcode 9.0+
- Swift 4+


## Installation

JNPhoneNumberView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JNPhoneNumberView'
```
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## JNPhoneNumberView

used to to show the country dial code and the phone number, you can click on the dial code and select another country from the countries picker, this view has a delegate methods to pass the international number and validity of it.

### Screenshots
<img src="https://user-images.githubusercontent.com/5199603/67772070-20783a80-fa62-11e9-8561-b4ecb5789c60.png" width="200" height="400"/>        <img src="https://user-images.githubusercontent.com/5199603/67772097-2d952980-fa62-11e9-8eb8-2c9aec955bb1.png" width="200" height="400"/>        <img src="https://user-images.githubusercontent.com/5199603/67772140-3c7bdc00-fa62-11e9-94f8-7c69fca5c7ae.gif" width="200" height="400"/>        <img src="https://user-images.githubusercontent.com/5199603/67772169-47cf0780-fa62-11e9-9391-a4fafa6cfc47.gif" width="200" height="400"/>

### Usage

- #### To add JNPhoneNumberView in interface builder:

    1. Drag an UIView and change the class to "JNPhoneNumberView"

    2. Add refrence for it in the view controller.

- #### Implement JNPhoneNumberViewDelegate:

     Set the 'delegate' in your view controller and implement the following methods:
        
     - Presenter View Controller to be used for presenting the Country list picker:
        
          ```swift
          func phoneNumberView(getPresenterViewControllerFor phoneNumberView: JNPhoneNumberView) -> UIViewController
          ```
        
     - Get Country picker configuration:
        ```swift
        func phoneNumberView(getCountryPickerAttributesFor phoneNumberView: JNPhoneNumberView) -> JNCountryPickerConfiguration
        ```
    
     -  Did change text with new national phone number and selected country:
        ```swift
        func phoneNumberView(didChangeText nationalNumber: String, country: JNCountry, forPhoneNumberView phoneNumberView: JNPhoneNumberView)
        ``` 
     
     -  Did end editing with bool value indicate if the phone number is valid, new national phone number and selected country:
        ```swift
        func phoneNumberView(didEndEditing nationalNumber: String, country: JNCountry, isValidPhoneNumber: Bool, forPhoneNumberView phoneNumberView: JNPhoneNumberView)
        ``` 
        
     -  Selected Country did changed with bool value indicate if the phone number is valid:
        ```swift
        func phoneNumberView(countryDidChanged country: JNCountry, isValidPhoneNumber: Bool, forPhoneNumberView phoneNumberView: JNPhoneNumberView)
        ``` 

- #### Implement JNPhoneNumberViewDataSourceDelegate:
    Set dataSourceDelegate in your view controller if you want to provide a source with custom countries instead of using the our like the following:

    ```swift
    func countryPickerViewControllerLoadCountryList(_ phoneNumberView: JNPhoneNumberView, completion: @escaping ([JNCountry]) -> Void, errorCompletion: @escaping (NSError) -> Void)
    ```
- #### View Customization:
    We provide appearance customization using **JNPhoneNumberViewConfiguration** that has the following attributtes:
    
     - ***countryDialCodeTitleColor*** Color for country dial code.
     - ***countryDialCodeTitleFont:*** Font for country dial code.    
     - ***phoneNumberTitleColor:*** Color for phone number textfield.
     - ***phoneNumberTitleFont:*** Font for phone number textfield.
     - ***phoneNumberPlaceHolder:*** Place hodler for phone number textfield.
     - ***leftToolBarBarButtonItemTitle:*** Title for Tool BarBar ButtonItem that appear of Keyboard.
     - ***maximumNumbrOfDigits:***  Maximum number of digits allowed to add. the defualt value is 30 digit

#### Public Methods:
1. Set a default country using this method, you just have to pass a country code such as "US", "PS":
    ```swift
    func setDefaultCountryCode(defaultCountryCode: String) 
    ```
2. Set View configuration to customization view appearance:
    ```swift
    func setViewConfiguration(_ configuration: JNPhoneNumberViewConfiguration) 
    ```
3. Set phone number in JNPhoneNumberView:
    ```swift
    func setPhoneNumber(phoneNumber: String)
    ```
4.  Set phone number from national number and country: 
    ```swift
    func setPhoneNumber(nationalNumber: String, preferredRegionCode: String)
    ```
5. Get phone number from JNPhoneNumberView:
    ```swift
    func getPhoneNumber() -> String 
    ```
 6. Is phone number valid:
    ```swift
    func isValidPhoneNumber() -> Bool
    ```

7. Get National Phone Number:
    ```swift
    func getNationalPhoneNumber() -> String
    ```

8. Get dial code:
    ```swift
    func getDialCode() -> String
    ```
    
#### Public Properties:
1. delegate : Picker Delegate
2. dataSourceDelegate: Data Source Delegate

## JNCountryPickerViewController

used to to show the countries list and select one of the countries, this view controller has a delegate methods to pass the selected country as JNCountry, also we provide the developer the flexiability to pass a custom country list insead of use the cached one.

### Screenshots
<img src="https://user-images.githubusercontent.com/5199603/67771968-f32b8c80-fa61-11e9-8b1d-3b22145d9e40.png" width="200" height="400"/>        <img src="https://user-images.githubusercontent.com/5199603/67771812-ad6ec400-fa61-11e9-8ce5-47c8a395812b.gif" width="200" height="400"/>        <img src="https://user-images.githubusercontent.com/5199603/67771936-e3ac4380-fa61-11e9-88a9-a4a80dc18da8.gif" width="200" height="400"/>

### Usage

#### To present JNCountryPickerViewController programmatically:

1. Initiate JNCountryPickerViewController.
    ```swift
      let countryPickerViewController = JNCountryPickerViewController()
    ```

2. Emped the view controller in navigation controller.
    ```swift
      let nevigationController = UINavigationController(rootViewController: countryPickerViewController)
    ```
3. Present the navigation controller modally.
    ```swift
      self.present(nevigationController, animated: true, completion: nil)
    ```
    
- ####  Implement JNCountryPickerViewControllerDelegate:

    Set the 'delegate' in your view controller and implement the following methods:
    
    - Did select Country
    ```swift
    func countryPickerViewController(_ controller: JNCountryPickerViewController, didSelectCountry country: JNCountry)
    ```
    
- ####  Implement JNPhoneNumberViewDataSourceDelegate:

    Set the 'dataSourceDelegate' in your view controller and implement the following methods:

    - Load country list from custom source
    ```swift
    func countryPickerViewControllerLoadCountryList(_ controller: JNCountryPickerViewController, completion: @escaping ([JNCountry]) -> Void, errorCompletion: @escaping (NSError) -> Void)
    ```
    
- #### View Customization:
    We provide appearance customization using **JNCountryPickerConfiguration** that has the following attributtes:
    
    - ***selectedTitleFont*** Selected item title font.
    - ***titleFont*** Not selected item title font.
    - ***selectedTitleColor*** Selected item title color.
    - ***titleColor*** Not selected item title color.
    - ***emptySearchMessageFont*** Message for empty search result.
    - ***emptySearchMessageColor*** Color for empty search result message.
    - ***searchBarTintColor*** Search bar tint color.
    - ***navigationBarColor*** Navigation bar color.
    - ***naigationBarTintColor*** Navigation bar tint color.
    - ***navigationBarTitle*** Navigation bar Title.
    - ***navigationBarTitleTextAttributes*** Navigation bar title text attributtes.
    - ***selectBarButtonTitle*** Select bar button title.
    - ***loadingAcivityIndicatorColor*** Loading acivity indicator color.    
    - ***emptySearchMessage*** Message for empty search result.
    - ***emptySearchImage*** Image for empty search result.
    - ***viewBackgroundColor*** View controller background color.
    - ***pickerLanguage*** Picker language.
    - ***tableCellInsets*** Cell margins.    
    - ***tableCellCornerRaduis*** Cell corner raduis.
    - ***tableCellBackgroundColor*** Cell background color.
    - ***showDialCode***  Show country dial code to appear after  country name.

#### Public Properties:

1. pickerConfiguration: you can set a custom configuration instead of the default configuration as described in view customization section.
2. selectedCountry: you can set country to be selected when picker opened.
2. delegate : Picker Delegate
3. dataSourceDelegate: Data Source Delegate

## Notes

1. Custom country entitiy must conform to JNCountry protocol that has the following:
    - ***code*** Country code.
    - ***name*** Country name.
    - ***dialCode*** Country dial code.
    
    The Country Data should Follow ***ISO 3166-1***
    
## Author

Hamzeh Khanfar & Jayel Zaghmoutt

## License

JNPhoneNumberView is available under the MIT license. See the LICENSE file for more info.
