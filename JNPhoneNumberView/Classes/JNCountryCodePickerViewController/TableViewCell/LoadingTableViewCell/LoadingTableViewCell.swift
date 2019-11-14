//
//  LoadingTableViewCell.swift
//  HarriManage
//
//  Created by Ali Hamad on 12/14/17.
//  Copyright © 2017 Harri Inc. All rights reserved.
//

import UIKit

/// Loading Table View Cell
class LoadingTableViewCell: UITableViewCell {
    
    /// loading Indicator
    private var loadingIndicator: UIActivityIndicatorView!
    
    /// Container View
    private var containerView: UIView!

    /// Container Leading Constraint
    private var containerViewLeadingConstraint: NSLayoutConstraint!
    
    /// Container Trailing Constraint
    private var containerViewTrailingConstraint: NSLayoutConstraint!
    
    /// Container Top Constraint
    private var containerViewTopConstraint: NSLayoutConstraint!
    
    /// Container Bottom Constraint
    private var containerViewBottomConstraint: NSLayoutConstraint!
    
    /// Rounding rect
    private var roundingCorners: UIRectCorner = UIRectCorner.allCorners
    
    /// Corner Radious
    private var cornerRadious: CGFloat = 0.0
    
    /**
     Draw
     */
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Round container view
        if !self.roundingCorners.isEmpty {
            UIUtil.round(view: self.containerView, frame: self.containerView.bounds, radious: self.cornerRadious, cornersToRound: self.roundingCorners)
        }
    }
    
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
    private func setupView() {
        
        // Set Cell Background Color
        self.backgroundColor = UIColor.clear
        
        // Set Content View Color
        self.contentView.backgroundColor = UIColor.clear
        
        // Init Container View
        self.containerView = UIView()
        self.containerView.backgroundColor = UIColor.clear
        
        // Add contaienr view
        self.contentView.addSubview(self.containerView)
        
        // Set Constraints
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerViewLeadingConstraint = self.containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0)
        self.containerViewLeadingConstraint.isActive = true
        
        self.containerViewTrailingConstraint = containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0)
        self.containerViewTrailingConstraint.isActive = true
        
        self.containerViewTopConstraint = containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0)
        self.containerViewTopConstraint.isActive = true
        
        self.containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        self.containerViewBottomConstraint.isActive = true
        
        // Build container view
        self.loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)

        // Add contaienr view
        self.containerView.addSubview(self.loadingIndicator)
        
        // Setup constraints
        self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.loadingIndicator.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        self.loadingIndicator.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        
        // Set cell selection style
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        //self.containerView.layoutIfNeeded()
    }
    
    /**
     Setup cell
     - Parameter activityIndicatorColor: loading Indicator Color
     - Parameter containerViewInsets: Container View Insets
     - Parameter containerViewBackgroundColor: Container View Background Color
     - Parameter isFirst: Is First Cell
     - Parameter isLast: Is Last Cell
     - Parameter cornerRadious: Corner Radious
     */
    func setup(activityIndicatorColor: UIColor, containerViewInsets: UIEdgeInsets = UIEdgeInsets.zero, containerViewBackgroundColor: UIColor = UIColor.white, isLast: Bool = false, isFirst: Bool = false, cornerRadious: CGFloat = 0.0) {
        
        // Set the loading Indicator Color
        self.loadingIndicator.color = activityIndicatorColor
        
        // Set the container view background color
        self.containerView.backgroundColor = containerViewBackgroundColor
        
        // Start animating indicator
        self.loadingIndicator.startAnimating()
        
        // Set Container View Constraint
        self.containerViewLeadingConstraint.constant = containerViewInsets.left
        self.containerViewTrailingConstraint.constant = -containerViewInsets.right
        self.containerViewTopConstraint.constant = containerViewInsets.top
        self.containerViewBottomConstraint.constant = containerViewInsets.bottom
        
        // reset container view mask
        self.containerView.layer.mask = nil
        
        // Set corner radious
        self.cornerRadious = cornerRadious
        
        // Set rounding corners according to is first and is last strings
        if isFirst && isLast {
            self.roundingCorners = UIRectCorner.allCorners
        } else if isFirst {
            self.roundingCorners = [UIRectCorner.topLeft, UIRectCorner.topRight]
        } else if isLast {
            self.roundingCorners = [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
        } else {
            self.roundingCorners = []
        }
        
        // Round container view
        if !self.roundingCorners.isEmpty {
            UIUtil.round(view: self.containerView, frame: self.containerView.bounds, radious: cornerRadious, cornersToRound: self.roundingCorners)
        }
    }
    
    // MARK: - Class methods
    
    /**
     Get cell reuse identifier
     - Returns : Cell reuse identifier
     */
    class func getReuseIdentifier() -> String {
        return "LoadingTableViewCell"
    }
    
    /**
     Register cell class in the table
     - Parameter tableView : The table view to register the cell in it
     */
    class func registerCell(in tableView: UITableView) {
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.getReuseIdentifier())
    }
    
    /**
     Get cell height
     - Parameter tableView : The table view to get cell height in it.
     */
    class func getCellHeight(in tableView: UITableView) -> CGFloat {
        return tableView.frame.size.height
    }
}
