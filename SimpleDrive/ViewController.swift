//
//  ViewController.swift
//  SimpleDrive
//
//  Created by Andrés Pizá Bückmann on 5/5/16.
//  Copyright © 2016 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiService = ApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiService.getAvisos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

