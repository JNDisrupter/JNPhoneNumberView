//
//  JNCountryTableViewCell.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

// JN Country Picker TableView Cell
class JNCountryPickerTableViewCell: HarriRoundedTableViewCell {
    
    /// Country name label
    @IBOutlet private weak var countryNameLabel: UILabel!

    /// flag label
    @IBOutlet private weak var flagLabel: UILabel!
    
    /// Picker Image view
    @IBOutlet private weak var pickerImageView: UIImageView!

    /// Container View Leading Constraint
    @IBOutlet private weak var containerViewLeadingConstraint: NSLayoutConstraint!
    
    /// Container View Trailing Constraint
    @IBOutlet private weak var containerViewTrailingConstraint: NSLayoutConstraint!
    
    /// Container View Top Constraint
    @IBOutlet private weak var containerViewTopConstraint: NSLayoutConstraint!
    
    /// Container View Bottom Constraint
    @IBOutlet private weak var containerViewBottomConstraint: NSLayoutConstraint!
    
    /**
     Awake from Nib
     */
    override func awakeFromNib() {
        super.awakeFromNib()

        // Set Selection Style
        self.selectionStyle = UITableViewCell.SelectionStyle.none

    }
    
    /**
     Setup
     - Parameter representable: The header representable object
     - Parameter containerViewInsets: Container View Insets
     - Parameter cornerRadious: Corner radious as CGFLoat
     - Parameter containerViewBackgroundColor: Container View BackgroundColor as UIColor.
     */
    func setup(representable: JNCountryPickerTableViewCellRepresentable, containerViewInsets: UIEdgeInsets, cornerRadious: CGFloat, containerViewBackgroundColor: UIColor) {
        
        super.setup(borderWidth: 0, borderColor: UIColor.clear, cornerRadious: cornerRadious, isFirst: true, isLast: true)
        
        // Set Background Color
        self.containerView.backgroundColor = containerViewBackgroundColor
        
        // Set title label
        self.countryNameLabel.attributedText = representable.countryNameAttributedString
        
        // Set flag
        self.flagLabel.attributedText = representable.flagAttributedString
        
        // Bundle
        let bundle = Bundle(for: JNCountryPickerTableViewCell.self)
        
        // Image name
        let imageName =  representable.isSelected ? "selectedPickerImage" : "unSelectedPickerImage"
        
        // Set picker image view
        self.pickerImageView.image = UIImage(named: imageName, in: bundle, compatibleWith: nil)!
        
        // Set Container View Contraints
        self.containerViewLeadingConstraint.constant = containerViewInsets.left
        self.containerViewTrailingConstraint.constant = containerViewInsets.right
        self.containerViewTopConstraint.constant = containerViewInsets.top
        self.containerViewBottomConstraint.constant = containerViewInsets.bottom
    }
    
    /**
     Get cell reuse identifier
     - Returns: Cell reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return "JNCountryPickerTableViewCell"
    }
    
    /**
     Get Cell Height
     - Returns : Cell height
     */
    class func getCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /**
     Register cell class in the table
     - Parameter tableView : The table view to register the cell in it
     */
    class func registerCell(in tableView: UITableView) {
        let bundle = Bundle(for: JNCountryPickerTableViewCell.self)
        let nib = UINib(nibName: "JNCountryPickerTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: JNCountryPickerTableViewCell.getReuseIdentifier())
    }
}
