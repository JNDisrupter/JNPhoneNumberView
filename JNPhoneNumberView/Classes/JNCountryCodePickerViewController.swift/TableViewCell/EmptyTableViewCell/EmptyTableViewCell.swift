//
//  EmptyTableViewCell.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

/// Component Size
private struct ComponentSize {
    static let emptyImageWidth: CGFloat                = 90.0
    static let emptyLabelTopFromImage: CGFloat         = 20.0
    static let containerViewMargin: CGFloat            = 15.0
}

/// Empty Table View Cell
class EmptyTableViewCell: UITableViewCell {
    
    /// Empty label
    private(set) var emptyLabel: UILabel!
    
    /// Cell image view
    private(set) var emptyImageView: UIImageView!
    
    /// Container view
    private(set) var containerView: UIView!
    
    /// Empty Image View Width Constraint
    private var emptyImageViewWidthConstraint: NSLayoutConstraint!
    
    /// Empty label Top Constraint
    private var emptyLabelTopConstraint: NSLayoutConstraint!
    
    /// Container Top Constraint
    private var containerTopConstraint: NSLayoutConstraint!

    /// Empty label bottom Constraint
    var emptyLabelBottomConstraint: NSLayoutConstraint!
    
    /**
     Initializer method
     */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup view
        self.setupView()
    }
    
    /**
     Initializer method
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup view
        self.setupView()
    }
    
    // MARK: - Build view
    
    /**
     Sets up the view
     */
    func setupView() {
        
        // Build container view
        self.containerView = UIView()
        
        // Add contaienr view
        self.contentView.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: ComponentSize.containerViewMargin).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -ComponentSize.containerViewMargin).isActive = true
        self.containerTopConstraint = self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: ComponentSize.emptyLabelTopFromImage)
        self.containerTopConstraint.isActive = true
        
        // Create empty image view
        self.emptyImageView = UIImageView()
        
        // Add empty image view
        self.containerView.addSubview(self.emptyImageView)
        self.emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyImageView.heightAnchor.constraint(equalTo: self.emptyImageView.widthAnchor, multiplier: 1).isActive = true
        self.emptyImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        self.emptyImageView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        self.emptyImageViewWidthConstraint = self.emptyImageView.widthAnchor.constraint(equalToConstant: ComponentSize.emptyImageWidth)
        self.emptyImageViewWidthConstraint.isActive = true
        
        // Create empty label
        self.emptyLabel = UILabel()
        
        // Add empty label view
        self.containerView.addSubview(self.emptyLabel)
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emptyLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        self.emptyLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        self.emptyLabelBottomConstraint = self.emptyLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        self.emptyLabelBottomConstraint.isActive = true
        
        self.emptyLabelTopConstraint = self.emptyLabel.topAnchor.constraint(equalTo: self.emptyImageView.bottomAnchor)
        self.emptyLabelTopConstraint.isActive = true
        
        // Setup cell label
        self.emptyLabel.textAlignment = NSTextAlignment.center
        self.emptyLabel.numberOfLines = 0
        
        // Set cell selection style
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // Set Background Color
        self.containerView.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
    // MARK: - Setup cell
    
    /**
     Setup cell
     - Parameter attributedString : The attributed string to set on the cell label
     - Parameter image : The image to set for the empty cell
     - Parameter emptyTableViewContentPosition: The content position in table view.
     */
    func setup(attributedString: NSAttributedString? = nil, image: UIImage? = nil) {
        
        // Set attributed string
        if attributedString != nil {
            self.emptyLabel.attributedText = attributedString
        } else {
            self.emptyLabel.attributedText = NSAttributedString()
        }
        
        // Set image
        if image != nil {
            
            // Set empty label top constraint
            self.emptyLabelTopConstraint.constant = ComponentSize.emptyLabelTopFromImage
            
            self.emptyImageViewWidthConstraint.constant = ComponentSize.emptyImageWidth
            self.emptyImageView?.image = image
        } else {
            
            // Set empty label top constraint
            self.emptyLabelTopConstraint.constant = 0
            
            self.emptyImageViewWidthConstraint.constant = 0
            self.emptyImageView?.image = nil
        }
    }
    
    // MARK: - Class methods
    
    /**
     Get cell reuse identifier
     - Returns : Cell reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return "EmptyTableViewCell"
    }
    
    /**
     Register cell class in the table
     - Parameter tableView : The table view to register the cell in it
     */
    class func registerCell(in tableView: UITableView) {
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.getReuseIdentifier())
    }
    
    /**
     Get cell height depends on the controller
     - Parameter tableView : The table view to get cell height in it.
     */
    class func getCellHeight(in tableView: UITableView) -> CGFloat {
        return tableView.frame.size.height
    }
}
