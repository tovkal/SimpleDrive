//
//  ApiService.swift
//  SimpleDrive
//
//  Created by Andrés Pizá Bückmann on 8/5/16.
//  Copyright © 2016 Andrés Pizá Bückmann. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit

class ApiService: NSObject {
    
    //var dateFormatter: NSDateFormatter
    
    override init() {
        //dateFormatter = NSDateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        super.init()
    }
    
    func getAvisos(hours: Int = 2) -> [Aviso]? {
        
        var avisos : [Aviso]?
        
        let url = "http://www.socialdrive.es/app/api.php?action=avisos&comarcas=18&usuario=1&format=json&horas=\(hours)"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    avisos = self.processAvisos(JSON(value)["avisos"])
                }
            case .Failure(let error):
                print(error)
            }
        }
        
        return avisos
    }
    
    private func processAvisos(avisosJSON: JSON) -> [Aviso] {
        
        var avisos = [Aviso]()
        
        for (_, aviso) in avisosJSON {
            //avisos.append(self.createAviso(aviso))
            self.createAviso(aviso)
        }
        
        return avisos
    }
    
    
    private func createAviso(avisoJSON: JSON) {
        print(avisoJSON["id"])
        /*return Aviso(id: avisoJSON["id"],
                     type: AvisoType(rawValue: avisoJSON["id_tipo_aviso"]),
                     text: avisoJSON["texto"],
                     timestamp: dateFormatter.dateFromString(avisoJSON["hora"]),
                     position: getPosition(avisoJSON["coordenadas"]))*/
    }
    
    /*private func getPosition(position: JSON) -> CLLocationCoordinate2D {
        
        let components = "39.797662/ 3.074311".componentsSeparatedByString("/")
        
        // Sometimes the lon coordinate has a space
        let doubleComponents: [Double] = components.map({Double($0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))})
        
        return CLLocationCoordinate2D(latitude: doubleComponents[0], longitude: doubleComponents[1])
    }*/
}
