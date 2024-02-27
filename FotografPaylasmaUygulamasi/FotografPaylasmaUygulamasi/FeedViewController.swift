//
//  FeedViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Ömer Yasir Önal on 24.02.2024.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postDizisi = [Post]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        firebaseVerilerileriAl()
        // Do any additional setup after loading the view.
    }
    
    func firebaseVerilerileriAl(){
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Post").order(by: "tarih", descending: true)
            .addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else{
                if snapshot?.isEmpty != true  && snapshot != nil{

                    self.postDizisi.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        if let gorselurl = document.get("gorselurl") as? String{
                            
                            if let email = document.get("email") as? String{
                                
                                if let yorum = document.get("yorum") as? String{
                                    
                                    let post = Post(email: email, yorum: yorum, gorselurl: gorselurl)
                                    
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                       
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = postDizisi[indexPath.row].email
        cell.yorumLabel.text = postDizisi[indexPath.row].yorum
        cell.postImageView.sd_setImage(with: URL(string: self.postDizisi[indexPath.row].gorselurl))
        return cell
        
    }

}
