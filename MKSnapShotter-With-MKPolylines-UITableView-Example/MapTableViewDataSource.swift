//
//  MapTableViewDataSource.swift
//  MKSnapShotter-With-MKPolylines-UITableView-Example
//
//  Created by Dzianis Baidan on 20.05.17.
//  Copyright © 2017 Dzianis Baidan. All rights reserved.
//

import UIKit

class MapTableViewDataSource: NSObject {
    
    // MARK: -
    // MARK: - Vars
    
    fileprivate weak var tableView: UITableView!
    
    // MARK: - Data
    
    fileprivate var cache: SnapshotterCache!
    fileprivate var routes: RandomRoutes!
    
    // MARK: - 
    // MARK: - Lifуcyle
    
    init(with tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.configure()
    }

}

// MARK: -
// MARK: - Table View Data Source

extension MapTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constant.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mapCell, for: indexPath) as! MapTableViewCell
        
        let key = self.routes.keys[indexPath.row % 3]
        let routes = self.routes.routes[indexPath.row % 3]
        
        
        cache.getMapShaphsotAtWorkout(id: key, routes: routes, result: { snapshot in
            cell.mapImageView.image = snapshot
        })
        
        cache.getPlaceAtWorkout(id: key, routes: routes, result: { place in
            cell.placeLabel.text = place
        })
        
        return cell
    }
    
}

// MARK: -
// MARK: - Table View Delegate

extension MapTableViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
}

// MARK: -
// MARK: - Configure Table View

fileprivate extension MapTableViewDataSource {
    
    enum Constant {
        static let numberOfSections = 1
        static let numberOfCells = 100
        static let rowHeight = CGFloat(90)
        static let mapCell = "MapTableViewCell"
    }

    
    func configure() {
        self.cache = SnapshotterCache()
        self.routes = RandomRoutes()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
}
