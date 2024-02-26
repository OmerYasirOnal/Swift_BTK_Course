//
//  FeedViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Ömer Yasir Önal on 24.02.2024.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = "murat@gmail.com"
        cell.yorumLabel.text = "murat"
        cell.postImageView.image = UIImage(named: "gorselSec")
        return cell
        
    }

}
