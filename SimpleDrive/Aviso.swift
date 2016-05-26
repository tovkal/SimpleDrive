//
//  Aviso.swift
//  SimpleDrive
//
//  Created by Andrés Pizá Bückmann on 8/5/16.
//  Copyright © 2016 Andrés Pizá Bückmann. All rights reserved.
//

import Foundation
import MapKit

class Aviso: NSObject, MKAnnotation {
    let id: String
    let type: AvisoType
    let title: String?
    let timestamp: NSDate
    let coordinate: CLLocationCoordinate2D
    let verificado: Bool
    
    init(id: String, type: AvisoType, text: String, timestamp: NSDate, position: CLLocationCoordinate2D, verificado: Bool) {
        self.id = id
        self.type = type
        self.title = text
        self.timestamp = timestamp
        self.coordinate = position
        self.verificado = verificado
        
        super.init()
    }
}