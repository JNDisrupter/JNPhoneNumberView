//
//  MainViewController.swift
//  JNPhoneNumberView_Example
//
//  Created by Hamzawy Khanfar on 10/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Choose JN Example"
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
