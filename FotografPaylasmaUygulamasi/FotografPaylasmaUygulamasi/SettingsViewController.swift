//
//  SettingsViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Ömer Yasir Önal on 24.02.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisyapTiklandi(_ sender: Any) {
        performSegue(withIdentifier: "toViiewController", sender: nil)
    }
    
  
    
}
