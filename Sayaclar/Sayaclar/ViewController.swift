//
//  ViewController.swift
//  Sayaclar
//
//  Created by Ömer Yasir Önal on 15.02.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    var kalanZaman = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        kalanZaman = 15
        label.text = "Zaman: \(kalanZaman)"

    }

    @IBAction func başlatTiklandi(_ sender: Any) {

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(zamanlayıcı), userInfo: nil, repeats: true)
        
    }
    
    @objc func zamanlayıcı(){
        kalanZaman = kalanZaman - 1

        label.text = "Zaman: \(kalanZaman)"
        
        if(kalanZaman)==0{
                    label.text = "Süre Bitti"
                    timer.invalidate()
            kalanZaman = 15
                }
    }
    
}

