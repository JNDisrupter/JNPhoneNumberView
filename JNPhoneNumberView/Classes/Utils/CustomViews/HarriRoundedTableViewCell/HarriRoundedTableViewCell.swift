//
//  HarriRoundedTableViewCell.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

/// Harri Rounded Table View Cell
class HarriRoundedTableViewCell: UITableViewCell {
    
    /// Container View
    @IBOutlet weak var containerView: UIView!
    
    /// Rounding rect
    private var roundingCorners: UIRectCorner = UIRectCorner.allCorners
    
    /// Border color
    private var borderColor: UIColor = UIColor.clear
    
    /// Border width
    private var borderWidth: CGFloat = 0.0
    
    /// Corner Radious
    private var cornerRadious: CGFloat = 0.0
    
    /**
     Draw
     */
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Round container view
        if !self.roundingCorners.isEmpty {
            UIUtil.round(view: self.containerView, frame: self.containerView.bounds, radious: self.cornerRadious, cornersToRound: roundingCorners)
        }
    }
    
    /**
     Setup
     - Parameter borderWidth: border width.
     - Parameter borderColor: border color.
     - Parameter cornerRadious: Corner Radious.
     - Parameter isFirst: Is first cell.
     - Parameter isLast: Is last cell.
     */
    func setup(borderWidth: CGFloat, borderColor: UIColor, cornerRadious: CGFloat, isFirst: Bool, isLast: Bool) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.cornerRadious = cornerRadious
        
        // reset container view mask
        self.containerView.layer.mask = nil
        
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
        
        // Add border to container view
        UIUtil.addBorder(toView: self.containerView, width: borderWidth, color: borderColor)
        
        // Round container view
        if !self.roundingCorners.isEmpty {
            UIUtil.round(view: self.containerView, frame: self.containerView.bounds, radious: self.cornerRadious, cornersToRound: roundingCorners)
        }
    }
}
