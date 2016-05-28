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
    
    var dateFormatter: NSDateFormatter
    
    override init() {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        super.init()
    }
    
    func getAvisos(hours: String = "2", completion: ([Aviso]) -> Void){
        
        var avisos = [Aviso]()
        
        let url = "http://www.socialdrive.es/app/api.php?action=avisos&comarcas=18&usuario=1&format=json&horas=\(hours)"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    avisos = self.processAvisos(JSON(value)["avisos"])
                    completion(avisos)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    private func processAvisos(avisosJSON: JSON) -> [Aviso] {
        
        var avisos = [Aviso]()
        
        print("Total avisos = \(avisosJSON.count)")
        
        for (_, avisoJSON) in avisosJSON {
            if let coordenadas = getPosition(avisoJSON["coordenadas"].stringValue) {
                let aviso = self.createAviso(avisoJSON, coordenadas: coordenadas)
                avisos.append(aviso)
            }
        }
        
        print("Total processed avisos = \(avisos.count)")
        
        return avisos
    }
    
    private func createAviso(avisoJSON: JSON, coordenadas: CLLocationCoordinate2D) -> Aviso {
        
        let id = avisoJSON["id"].stringValue,
        avisoType = AvisoType(rawValue: Int(avisoJSON["id_tipo_aviso"].stringValue)!)!,
        text = avisoJSON["texto"].stringValue,
        timestamp = dateFormatter.dateFromString(avisoJSON["hora"].stringValue)!,
        position = coordenadas,
        verificado = (Int(avisoJSON["verificar"].stringValue)! == 0)
        
        return Aviso(id: id, type: avisoType, text: text, timestamp: timestamp, position: position, verificado: verificado)
    }
    
    private func getPosition(position: String) -> CLLocationCoordinate2D? {
        
        if position.characters.count <= 1 {
            return nil
        }
        
        let components = position.componentsSeparatedByString("/")
        
        // Sometimes the lon coordinate has a space
        let doubleComponents: [Double] = components.map({Double($0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))!})
        
        return CLLocationCoordinate2D(latitude: doubleComponents[0], longitude: doubleComponents[1])
    }
}
