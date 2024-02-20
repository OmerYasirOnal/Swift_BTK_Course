//
//  ListViewController.swift
//  HaritalarUygulamasi
//
//  Created by Ömer Yasir Önal on 19.02.2024.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var secilenYerIsmi = ""
    var secilenID = UUID()
    var isimDizisi = [String]()
    var idDizisi = [UUID]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        
        veriAl()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(veriAl), name: NSNotification.Name(rawValue: "verilerGirildi"), object: nil)

        
        
    }
    @objc func veriAl(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Yer")
        request.returnsObjectsAsFaults = false
        
        do{
            let sonuclar = try context.fetch(request)
            
            if sonuclar.count > 0 {
                
                isimDizisi.removeAll(keepingCapacity: false)
                idDizisi.removeAll(keepingCapacity: false)
                
                for sonuc in sonuclar as! [NSManagedObject]{
                    if let isim = sonuc.value(forKey: "isim") as? String{
                        isimDizisi.append(isim)
                    }
                    if let id = sonuc.value(forKey: "id") as? UUID{
                        idDizisi.append(id)
                    }
                }
                
                tableView.reloadData()
            }
        } catch{
            
        }
    }
    
    @objc func addButton(){
        secilenYerIsmi = ""
        performSegue(withIdentifier: "toMapsVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isimDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = isimDizisi[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapsVC"{
            let destinationVC = segue.destination as! MapsViewController
            destinationVC.secilenIsım = secilenYerIsmi
            destinationVC.secilenId = secilenID
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secilenYerIsmi = isimDizisi[indexPath.row]
        secilenID = idDizisi[indexPath.row]
        performSegue(withIdentifier: "toMapsVC", sender: nil)
    }
    
}
