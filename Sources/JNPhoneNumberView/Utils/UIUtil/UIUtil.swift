//
//  UIUtil.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

class UIUtil {
    
    // MARK: - Rounding
    
    /**
     Round any view corners for given radious
     - parameter view : The view to round
     - parameter radious : The rounding radious
     - note : This method will set clipToBound to true
     */
    public class func round(view: UIView, radious: CGFloat) {
        view.layer.cornerRadius = radious
        view.clipsToBounds = true
    }
    
    /**
     Round view corners for specific corners
     - parameter view : The view to round
     - parameter frame : The view frame
     - parameter radious : The rounding radious
     - parameter cornersToRound : The corners to round
     */
    public class func round(view: UIView, frame: CGRect, radious: CGFloat, cornersToRound: UIRectCorner) {
        
        let path = UIBezierPath(roundedRect:frame,
                                byRoundingCorners:cornersToRound,
                                cornerRadii: CGSize(width: radious, height:  radious))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    // MARK: - Borders
    
    /**
     Add border for view
     - parameter toView : The view to add border to
     - parameter width : The width for the borders
     - parameter color : The borders color
     */
    public class func addBorder(toView: UIView, width: CGFloat, color: UIColor) {
        toView.layer.borderColor = color.cgColor
        toView.layer.borderWidth = width
    }
}
