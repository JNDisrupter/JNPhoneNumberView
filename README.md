# JNPhoneNumberView

[![CI Status](https://img.shields.io/travis/hamzakhanfar/JNPhoneNumberView.svg?style=flat)](https://travis-ci.org/hamzakhanfar/JNPhoneNumberView)
[![Version](https://img.shields.io/cocoapods/v/JNPhoneNumberView.svg?style=flat)](https://cocoapods.org/pods/JNPhoneNumberView)
[![License](https://img.shields.io/cocoapods/l/JNPhoneNumberView.svg?style=flat)](https://cocoapods.org/pods/JNPhoneNumberView)
[![Platform](https://img.shields.io/cocoapods/p/JNPhoneNumberView.svg?style=flat)](https://cocoapods.org/pods/JNPhoneNumberView)

**JNPhoneNumberView** used to to show the country dial code and the phone number, you can click on the dial code and select another country from the countries picker, this view has a delegate methods to pass the international number and validity of it.

### Screenshots
<img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/screenshot2.png" width="200" height="400"/>        <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/phonenumber1.gif" width="200" height="400"/>        <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/phonenumber2.gif" width="200" height="400"/>

**JNCountryPickerViewController** used to to show the countries list and select one of the countries, this view controller has a delegate methods to pass the selected country as JNCountry object, also we provide the developer the flexiability to pass a custom country list insead of use the cached one.

### Screenshots
<img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/screenshot1.png" width="200" height="400"/>     <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/countrypicker1.gif" width="200" height="400"/>    <img src="https://github.com/JNDisrupter/JNPhoneNumberView/raw/enhancements/Images/countrypicker2.gif" width="200" height="400"/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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

## JNPhoneNumberView Usage

#### To add JNPhoneNumberView in interface builder:

1. Drag an UIView and change the class to "JNPhoneNumberView"

2. Add refrence for it in the view controller.

3. Implement JNPhoneNumberViewDelegate in your view controller and set delegate like the following:

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

4. Implement JNPhoneNumberViewDataSourceDelegate in your view controller and set delegate if you want to provide a source with custom countries instead of using the local like the following:

```swift

/**
Get country code list
*/
func phoneNumberViewDataSourceGetCountryList(completion: ([JNCountry]) -> Void)

```

#### Public Methods:
1. setDefaultCountryCode(_ defaultCountryCode: String): you can set a default country using this method, you just have to pass a country code such as "US", "PS".
2. public func setupViewAttributes(_ attributes: JNPhoneNumberViewAttributes) : with this method you can pass a custom attributes.

#### Public Properties:
1. delegate : Picker Delegate
2. dataSourceDelegate: Data Source Delegate

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
