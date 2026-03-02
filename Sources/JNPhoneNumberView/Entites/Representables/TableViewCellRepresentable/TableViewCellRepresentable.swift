//
//  TableViewCellRepresentable.swift
//  CountryPicker
//
//  Created by Hamzawy Khanfar on 03/10/2019.
//  Copyright © 2019 Hamzawy Khanfar. All rights reserved.
//

import UIKit

/// Table View Cell Representable
protocol TableViewCellRepresentable {
    
    /// Cell Height
    var cellHeight : CGFloat { get set }
     
    /// Item data index
    var itemDataIndex: Int { get set }
}
