//
//  RandomRoutes.swift
//  MKSnapShotter-With-MKPolylines-UITableView-Example
//
//  Created by Dzianis Baidan on 21.05.17.
//  Copyright © 2017 Dzianis Baidan. All rights reserved.
//

import UIKit
import CoreLocation

struct RandomRoutes {
    
    // MARK: -
    // MARK: - Public
    
    let keys: [Int]!
    let routes: [[CLLocation]]!
    
    init() {
        self.keys = [firstRoutesKey, secondtRoutesKey, thirdRoutesKey]
        self.routes = [firstRoutes, secondRoutes, thirdRoutes]
    }
    
    // MARK: -
    // MARK: - Private
    
    private let firstRoutes = [CLLocation(latitude: 59.8717325, longitude: 30.3205463),
                       CLLocation(latitude: 59.864535, longitude: 30.336213),
                       CLLocation(latitude: 59.8754647, longitude: 30.3307357),
                       CLLocation(latitude: 59.8717204, longitude: 30.3205506),
                       CLLocation(latitude: 59.8663138, longitude: 30.3207839),
                       CLLocation(latitude: 59.8663135, longitude: 30.3213004),
                       CLLocation(latitude: 59.8649322, longitude: 30.3234633),
                       CLLocation(latitude: 59.8645534, longitude: 30.3362114),
                       CLLocation(latitude: 59.8645531, longitude: 30.3370141),
                       CLLocation(latitude: 59.8718386, longitude: 30.3365908),
                       CLLocation(latitude: 59.8645531, longitude: 30.3370141),
                       CLLocation(latitude: 59.8718386, longitude: 30.3365908),
                       CLLocation(latitude: 59.8761433, longitude: 30.3362158),
                       CLLocation(latitude: 59.8760513, longitude: 30.3290751),
                       CLLocation(latitude: 59.8755629, longitude: 30.3291219),
                       CLLocation(latitude: 59.875593, longitude: 30.3306001)]
    
    private let firstRoutesKey = 1
    
    private let secondRoutes = [CLLocation(latitude: 59.9003334, longitude: 30.3724525),
                       CLLocation(latitude: 59.9018394, longitude: 30.3639019),
                       CLLocation(latitude: 59.9046421, longitude: 30.3646018),
                       CLLocation(latitude: 59.9055689, longitude: 30.354357),
                       CLLocation(latitude: 59.9075773, longitude: 30.3457626)]
    
    private let secondtRoutesKey = 2
    
    private let thirdRoutes = [CLLocation(latitude: 59.8717325, longitude: 30.3082302),
                       CLLocation(latitude: 59.9355887, longitude: 30.3240366),
                       CLLocation(latitude: 59.9325648, longitude: 30.3485133),
                       CLLocation(latitude: 59.9326285, longitude: 30.3480025),
                       CLLocation(latitude: 59.9290081, longitude: 30.3477869),
                       CLLocation(latitude: 59.9282138, longitude: 30.3475631),
                       CLLocation(latitude: 59.9249905, longitude: 30.3451385),
                       CLLocation(latitude: 59.9209738, longitude: 30.3381226)]
    
    private let thirdRoutesKey = 3

}
