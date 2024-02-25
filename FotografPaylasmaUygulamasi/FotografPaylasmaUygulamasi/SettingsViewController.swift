//
//  SettingsViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Ömer Yasir Önal on 24.02.2024.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisyapTiklandi(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViiewController", sender: nil)

        } catch{
            print("Hata!")
        }
        
    }
    
  
    
}
