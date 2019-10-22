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
<img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/screenshot2.png" width="200" height="400"/>        <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/screenshot3.png" width="200" height="400"/>        <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/phonenumber1.gif" width="200" height="400"/>        <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/phonenumber2.gif" width="200" height="400"/>

### Usage

- #### To add JNPhoneNumberView in interface builder:

    1. Drag an UIView and change the class to "JNPhoneNumberView"

    2. Add refrence for it in the view controller.

- #### Implement JNPhoneNumberViewDelegate:

     Set the 'delegate' in your view controller and implement the following methods:
        
     - Presenter View Controller to be used for presenting the Country list picker:
        
          ```swift
          func phoneNumberViewGetPresenterViewController() -> UIViewController
          ```
        
     - Get Country picker configuration:
        ```swift
        func phoneNumberViewGetCountryPickerAttributes() -> JNCountryPickerConfiguration
        ```
    
     -  Did change text:
        ```swift
        func phoneNumberView(didChangeText text: String)
        ``` 
     
     -  Did end Editing with bool value indicate if the phone number is valid:
        ```swift
        func phoneNumberView(didEndEditing text: String, isValidPhoneNumber: Bool)
        ``` 
        
     -  Selected Country did changed with bool value indicate if the phone number is valid:
        ```swift
        func phoneNumberView(countryDidChanged country: JNCountry, isValidPhoneNumber: Bool)
        ``` 

- #### Implement JNPhoneNumberViewDataSourceDelegate:
    Set dataSourceDelegate in your view controller if you want to provide a source with custom countries instead of using the our like the following:

    ```swift
    func countryPickerViewControllerLoadCountryList(completion: @escaping ([JNCountry]) -> Void, errorCompletion: @escaping (NSError) -> Void)
    ```
- #### View Customization:
    We provide appearance customization using **JNPhoneNumberViewConfiguration** that has the following attributtes:
    
     - ***countryDialCodeTitleColor*** Color for country dial code.
     - ***countryDialCodeTitleFont:*** Font for country dial code.    
     - ***phoneNumberTitleColor:*** Color for phone number textfield.
     - ***phoneNumberTitleFont:*** Font for phone number textfield.
     - ***phoneNumberPlaceHolder:*** Place hodler for phone number textfield.
     - ***leftToolBarBarButtonItemTitle:*** Title for Tool BarBar ButtonItem that appear of Keyboard.
        

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
4. Get phone number from JNPhoneNumberView:
    ```swift
    func getPhoneNumber() -> String 
    ```
 5. Is phone number valid:
    ```swift
    func isValidPhoneNumber() -> Bool
    ```

#### Public Properties:
1. delegate : Picker Delegate
2. dataSourceDelegate: Data Source Delegate
**JNCountryPickerViewController** used to to show the countries list and select one of the countries, this view controller has a delegate methods to pass the selected country as JNCountry object, also we provide the developer the flexiability to pass a custom country list insead of use the cached one.

### Screenshots
<img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/screenshot1.png" width="200" height="400"/>     <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/countrypicker1.gif" width="200" height="400"/>    <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/countrypicker2.gif" width="200" height="400"/>

## JNCountryPickerViewController Usage

#### To present JNCountryPickerViewController programmatically:

1. Initiate JNCountryPickerViewController with nib name, the nib name is the same with view controller name.

2. Present the view controller modally.

3. Implement JNCountryPickerViewControllerDelegate in your view controller and set delegate like the following:

```swift

/**
Did Select Country
- Parameter country: country as JNCountry.
*/
func countryPickerViewController(didSelectCountry country: JNCountry)

```
4. Implement JNPhoneNumberViewDataSourceDelegate in your view controller and set delegate if you want to provide a data source with custom countries instead of using the local cached countries like the following:

```swift

/**
Load country list
- Parameter completion: completion block
*/
func countryPickerViewControllerLoadCountryList(completion: ([JNCountry]) -> Void)

```
#### Public Properties:

1. pickerConfiguration: you can set a custom configuration instead of the default, such as colors, titles and more.
2. selectedCountry: Selected countryt
2. delegate : Picker Delegate
3. dataSourceDelegate: Data Source Delegate

## Notes

1. Custom country entitiy must conform to JNCountry protocol.

## Author

Hamzeh Khanfar & Jayel Zaghmoutt

## License

JNPhoneNumberView is available under the MIT license. See the LICENSE file for more info.
