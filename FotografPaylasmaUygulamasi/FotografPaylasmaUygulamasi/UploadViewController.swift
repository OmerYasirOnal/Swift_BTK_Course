//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Ömer Yasir Önal on 24.02.2024.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yorumTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
               view.addGestureRecognizer(tapGesture)
               
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)

    }
    @objc func selectImage(){
           let picker = UIImagePickerController()
           picker.delegate = self
           picker.sourceType = .photoLibrary
           present(picker, animated: true, completion: nil)
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
              // Klavyeyi gizle
              view.endEditing(true)
          }
    
    @IBAction func uploadButtonTiklandi(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { (storagemetadata, error) in
                if error != nil {
                    hataMesajiGoster(title: "Hata", mesaj: error?.localizedDescription ?? "Hata Aldınız! Tekrar Deneyiniz!")
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl{
                                
                                
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = ["gorselurl" : imageUrl, "yorum" : self.yorumTextField.text!, "email" : Auth.auth().currentUser!.email, "tarih" : FieldValue.serverTimestamp() ] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) {
                                    (error) in
                                    if error != nil {
                                        hataMesajiGoster(title: "Hata", mesaj: "Hata aldınız, Lütfen Tekrar Deneyiniz!")
                                    } else {
                                        
                                        self.yorumTextField.text = ""
                                        self.imageView.image = UIImage(named: "gorselSec")
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                            
                        
                            
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        
        func hataMesajiGoster(title: String, mesaj: String){
            let alert = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertController.Style.alert)
            
            let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(button)
        }
        
    }
    
}
