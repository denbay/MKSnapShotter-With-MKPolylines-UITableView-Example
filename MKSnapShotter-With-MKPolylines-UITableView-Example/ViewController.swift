//
//  ViewController.swift
//  MKSnapShotter-With-MKPolylines-UITableView-Example
//
//  Created by Dzianis Baidan on 20.05.17.
//  Copyright © 2017 Dzianis Baidan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - 
    // MARK: - Vars

    // - Layout
    
    @IBOutlet weak var tableView: UITableView!
    
    // - Data
    
    fileprivate var dataSource: MapTableViewDataSource!
    
    // MARK: -
    // MARK: - Lifycycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }

}

// MARK: - 
// MARK: - Configure

fileprivate extension ViewController {
    
    func configure() {
        self.dataSource = MapTableViewDataSource(with: self.tableView)
    }
    
}

