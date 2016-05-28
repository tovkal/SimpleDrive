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
    let subtitle: String?
    let timestamp: NSDate
    let coordinate: CLLocationCoordinate2D
    let verificado: Bool
    
    init(id: String, type: AvisoType, text: String, timestamp: NSDate, position: CLLocationCoordinate2D, verificado: Bool) {
        self.id = id
        self.type = type
        self.timestamp = timestamp
        self.coordinate = position
        self.verificado = verificado
        
        if text.characters.count > 40 {
            let index = text.startIndex.advancedBy(40)
            self.title = text.substringToIndex(index)
            self.subtitle = text.substringFromIndex(index)
        } else {
            self.title = text
            self.subtitle = nil
        }
    }
}