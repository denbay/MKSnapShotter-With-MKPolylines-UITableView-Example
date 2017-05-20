//
//  MapSnapshotterService.swift
//  MKSnapShotter-With-MKPolylines-UITableView-Example
//
//  Created by Dzianis Baidan on 21.05.17.
//  Copyright © 2017 Dzianis Baidan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapSnapshotterService {
    
    // MARK: -
    // MARK: - Vars
    
    fileprivate var routes: [CLLocation]!
    fileprivate var size: CGSize!
    
    // MARK: -
    // MARK: - Public Methods
    
    init(with routes: [CLLocation], size: CGSize) {
        self.routes = routes
        self.size = size
    }
    
    public func image( completion: @escaping ((UIImage) -> ()) ) {
        getImage { image in
            completion(image)
        }
    }
    
}

// MARK: -
// MARK: - Filter and size logic

fileprivate extension MapSnapshotterService {
    
    fileprivate enum Constant {
        static let lineWidth = CGFloat(2)
        static let endPointSize = CGFloat(9)
        static let startPointBigSize = CGFloat(17)
        static let startPointSmallSize = CGFloat(11)
        
        static let mapOverlayMinimumDistance = Double(10)
        
        static let blueColor = UIColor.init(red: 74/255, green: 144/255, blue: 226/225, alpha: 1).cgColor
        
        static let latitudeDelta = Double(0.003)
        static let longitudeDelta = Double(0.003)
    }
    
    func getImage(completion: @escaping ( (UIImage) -> ())) {
        
        var coord = [CLLocationCoordinate2D]()
        for loc in self.routes {
            coord.append(loc.coordinate)
        }
        
        let polyLine = MKPolyline(coordinates: &coord, count: coord.count)
        var region = MKCoordinateRegionForMapRect(polyLine.boundingMapRect)
        region.span.latitudeDelta += Constant.latitudeDelta
        region.span.longitudeDelta += Constant.longitudeDelta
        
        let options = MKMapSnapshotOptions()
        options.size = size
        options.region = region
        options.scale = UIScreen.main.scale
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start(with: DispatchQueue.global(qos: .userInitiated)) { snapshot, error in
            guard let snapshot = snapshot else { return }
            DispatchQueue.main.async {
                completion(self.drawLineOnImage(snapshot: snapshot, filteredLocations: self.routes))
            }
        }
        
    }
    
}

// MARK: -
// MARK: - Draw map path

fileprivate extension MapSnapshotterService {
    
    func drawLineOnImage(snapshot: MKMapSnapshot, filteredLocations: [CLLocation]) -> UIImage {
        let image = snapshot.image
        
        UIGraphicsBeginImageContextWithOptions(self.size, true, 0)
        
        // draw original image into the context
        image.draw(at: CGPoint.zero)
        
        // get the context for CoreGraphics
        let context = UIGraphicsGetCurrentContext()
        
        // set stroking width and color of the context
        context!.setLineWidth(Constant.lineWidth)
        context!.setStrokeColor(Constant.blueColor)
        
        context!.move(to: snapshot.point(for: filteredLocations[0].coordinate))
        for i in 0...filteredLocations.count-1 {
            context!.addLine(to: snapshot.point(for: filteredLocations[i].coordinate))
            context!.move(to: snapshot.point(for: filteredLocations[i].coordinate))
        }
        
        // apply the stroke to the context
        context!.strokePath()
        
        context!.saveGState()
        
        // add END point
        let lastCoordinatePoint = snapshot.point(for: filteredLocations.first!.coordinate)
        let endLocationRect = CGRect(x: lastCoordinatePoint.x - Constant.endPointSize / 2,
                                     y: lastCoordinatePoint.y - Constant.endPointSize / 2,
                                     width: Constant.endPointSize,
                                     height: Constant.endPointSize)
        
        context!.setFillColor(Constant.blueColor)
        context!.fillEllipse(in: endLocationRect)
        
        // add START points (white, blue)
        let firstCoordinatePoint = snapshot.point(for: filteredLocations.last!.coordinate)
        let firstLocationRect = CGRect(x: firstCoordinatePoint.x - Constant.startPointBigSize / 2,
                                       y: firstCoordinatePoint.y - Constant.startPointBigSize / 2,
                                       width: Constant.startPointBigSize,
                                       height: Constant.startPointBigSize)
        context!.setFillColor(UIColor.white.cgColor)
        context!.fillEllipse(in: firstLocationRect)
        
        let firstBlueCoordinatePoint = snapshot.point(for: filteredLocations.last!.coordinate)
        let firstBlueLocationRect = CGRect(x: firstBlueCoordinatePoint.x - Constant.startPointSmallSize / 2,
                                           y: firstBlueCoordinatePoint.y - Constant.startPointSmallSize / 2,
                                           width: Constant.startPointSmallSize,
                                           height: Constant.startPointSmallSize)
        
        context!.setFillColor(Constant.blueColor)
        context!.fillEllipse(in: firstBlueLocationRect)
        
        context!.restoreGState()
        
        // get the image from the graphics context
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end the graphics context
        UIGraphicsEndImageContext()
        
        return resultImage!
    }
    
}
