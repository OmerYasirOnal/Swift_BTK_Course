//
//  ViewController.swift
//  SuperKahramanKitabi
//
//  Created by Ömer Yasir Önal on 15.02.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var superKahramanGorselIsimleri = [String]()
    var superKahramanIsimleri = [String]()
    var secilenIsim = ""
    var secilenGorsel = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        superKahramanIsimleri.append("Batman")
        superKahramanIsimleri.append("Superman")
        superKahramanIsimleri.append("Iron Man")
        superKahramanIsimleri.append("Spiderman")
        superKahramanIsimleri.append("Hulk")
        
        superKahramanGorselIsimleri.append("batman")
        superKahramanGorselIsimleri.append("superman")
        superKahramanGorselIsimleri.append("ironman")
        superKahramanGorselIsimleri.append("spiderman")
        superKahramanGorselIsimleri.append("hulk")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superKahramanIsimleri.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =  superKahramanIsimleri[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Silme işlemi için arrayden ilgili veriyi kaldır
            superKahramanIsimleri.remove(at: indexPath.row)
            superKahramanGorselIsimleri.remove(at: indexPath.row)
            
            // TableView'daki hücreyi kaldır
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secilenIsim = superKahramanIsimleri[indexPath.row]
        secilenGorsel = superKahramanGorselIsimleri[indexPath.row]

        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.secilenKahramanIsmi = secilenIsim
            destinationVC.secilenKahramanGorselIsmi = secilenGorsel
        }
    }

}

