//
//  ViewController.swift
//  AlisverisListesi
//
//  Created by Ömer Yasir Önal on 16.02.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addinButton))
    }
    
    @objc func addinButton(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }


}

