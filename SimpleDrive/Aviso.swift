//
//  Aviso.swift
//  SimpleDrive
//
//  Created by Andrés Pizá Bückmann on 8/5/16.
//  Copyright © 2016 Andrés Pizá Bückmann. All rights reserved.
//

import Foundation
import MapKit

struct Aviso {
    let id: Int
    let type: AvisoType
    let text: String
    let timestamp: NSDate
    let position: CLLocationCoordinate2D
    let verificado = false
}