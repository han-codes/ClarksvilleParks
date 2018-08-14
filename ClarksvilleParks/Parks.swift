//
//  Parks.swift
//  ClarksvilleParks
//
//  Created by Hannie Kim on 8/14/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit
import MapKit

// Map annotations need to inherit from NSObject because it uses Objective-C code
class Parks: NSObject, MKAnnotation {
    //    var amenities = [String]()
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
