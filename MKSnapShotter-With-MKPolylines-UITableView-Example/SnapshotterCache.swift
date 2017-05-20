//
//  SnapshotterCache.swift
//  MKSnapShotter-With-MKPolylines-UITableView-Example
//
//  Created by Dzianis Baidan on 20.05.17.
//  Copyright © 2017 Dzianis Baidan. All rights reserved.
//

import UIKit
import CoreLocation

class SnapshotterCache {
    
    // MARK: -
    // MARK: - Vars
    
    fileprivate var mapsShapshots = [Int : UIImage]()
    fileprivate var places = [Int : String]()
    
    typealias imageCompletionHandler = ((UIImage) -> ())
    typealias placeCompletionHandler = ((String) -> ())
    
    fileprivate enum Constant {
        static let mapSize = CGSize(width: 60, height: 60)
        static let geoCoderKeyName = "Name"
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    init() {}
    
    public func getMapShaphsotAtWorkout(id: Int, routes: [CLLocation], result: @escaping imageCompletionHandler) {
        self.getMapSnapshot(id: id, routes: routes) { snapshot in
            result(snapshot)
        }
    }
    
    public func getPlaceAtWorkout(id: Int, routes: [CLLocation], result: @escaping placeCompletionHandler) {
        self.getPlace(id: id, routes: routes) { place in
            result(place)
        }
    }
    
}

// MARK: -
// MARK: - Private methods
// MARK: - Map snapshot

fileprivate extension SnapshotterCache {
    
    func getMapSnapshot(id: Int, routes: [CLLocation], result: @escaping imageCompletionHandler) {
        if let snapshotImage = getMapSnapshotFromCache(id: id) {
            result(snapshotImage)
        } else {
            createMapSnapshot(id: id, routes: routes, result: { [weak self] image in
                self?.addMapSnapshotToCache(id: id, image: image)
                result(image)
            })
        }
    }
    
    private func createMapSnapshot(id: Int, routes: [CLLocation], result: @escaping imageCompletionHandler) {
       let snapShotService = MapSnapshotterService(with: routes, size: Constant.mapSize)
       snapShotService.image { image in
         result(image)
       }
    }
    
    private func getMapSnapshotFromCache(id: Int) -> UIImage? {
        if let snapshotImage = mapsShapshots[id] {
            return snapshotImage
        } else {
            return nil
        }
    }
    
    private func addMapSnapshotToCache(id: Int, image: UIImage) {
        mapsShapshots.updateValue(image, forKey: id)
    }
    
}

// MARK: -
// MARK: - Place

fileprivate extension SnapshotterCache {
    
    func getPlace(id: Int, routes: [CLLocation], result: @escaping placeCompletionHandler) {
        if let place = getPlaceFromCache(id: id) {
            result(place)
        } else {
            createPlace(id: id, routes: routes, result: { [weak self] place in
                self?.addPlaceToCache(id: id, place: place)
                result(place)
            })
        }
    }
    
    private func createPlace(id: Int, routes: [CLLocation], result: @escaping placeCompletionHandler) {
        DispatchQueue.global().async {
            if let firstLocation = routes.first {
                let geoCoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(firstLocation , completionHandler: { (placemarks, error) in
                    DispatchQueue.main.async {
                        let placeMark = placemarks?.first
                        if let locationName = placeMark?.addressDictionary?[Constant.geoCoderKeyName] as? NSString {
                            result(locationName as String)
                        } else {
                            result("")
                        }
                    }
                })
            }
        }
    }
    
    private func getPlaceFromCache(id: Int) -> String? {
        if let place = places[id] {
            return place
        } else {
            return nil
        }
    }
    
    private func addPlaceToCache(id: Int, place: String) {
        places.updateValue(place, forKey: id)
    }
    
}
