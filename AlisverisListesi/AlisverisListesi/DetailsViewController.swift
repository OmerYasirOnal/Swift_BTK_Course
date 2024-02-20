//
//  DetailsViewController.swift
//  AlisverisListesi
//
//  Created by Ömer Yasir Önal on 16.02.2024.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productSize: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var secilenIsim = ""
    var secilenId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if secilenIsim != ""{
            imageView.isUserInteractionEnabled = false
            productName.isEnabled = false
            productSize.isEnabled = false
            productPrice.isEnabled = false
            saveButton.isHidden = true

            if let uuid = secilenId?.uuidString{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuid)
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let sonuclar = try context.fetch(fetchRequest)
                    
                    if sonuclar.count > 0 {
                        for sonuc in sonuclar as! [NSManagedObject]{
                            if let isim = sonuc.value(forKey: "isim") as? String{
                                productName.text = isim
                            }
                            if let fiyat = sonuc.value(forKey: "fiyat") as? Int{
                                productPrice.text = String(fiyat)
                            }
                            if let beden = sonuc.value(forKey: "beden") as? String{
                                productSize.text = beden
                            }
                            if let gorselData = sonuc.value(forKey: "gorsel") as? Data{
                                let image = UIImage(data: gorselData)
                                imageView.image  = image
                            }
                            
                                
                        }
                    }
                    
                } catch {
                    
                }
            }
                
        } else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
            productName.text = ""
            productSize.text = ""
            productPrice.text = ""
            imageView.isUserInteractionEnabled = true


        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        productName.isEnabled = true
        productSize.isEnabled = true
        productPrice.isEnabled = true
        present(picker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = pickedImage
            }
        saveButton.isEnabled = true
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
           // Klavyeyi gizle
           view.endEditing(true)
       }

     
    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let alisveris = NSEntityDescription.insertNewObject(forEntityName: "Alisveris", into: context)
                                                            
        alisveris.setValue(productName.text!, forKey: "isim")
        alisveris.setValue(productSize.text!, forKey: "beden")
                                                        
        if let fiyat = Int(productPrice.text!){
            alisveris.setValue(fiyat, forKey: "fiyat")
        }
        alisveris.setValue(UUID(), forKey: "id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        alisveris.setValue(data, forKey: "gorsel")
        
        do{
            try context.save()
                print("Kayıt Edildi")
        }catch{
            print("Hata var")

        }
                        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "verilerGirildi"), object: nil)
        navigationController?.popViewController(animated: true)
        productName.text = ""
        productSize.text = ""
        productPrice.text = ""
        imageView.image = nil


        
    }
    
}
