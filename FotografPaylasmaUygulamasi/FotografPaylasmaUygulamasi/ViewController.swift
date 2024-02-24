//
//  ViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Ömer Yasir Önal on 21.02.2024.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func girisYapTiklandi(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){
                (AuthDataResult,error) in
                if error != nil {
                    self.hataMesajı(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata Aldınız. Tekrar Deneyiniz!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            hataMesajı(titleInput: "Hata!", messageInput: "Email ve Parola giriniz!")
        }
    }
    
    @IBAction func kayitolTiklandi(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){
                (AuthDataResult,error) in
                if error != nil {
                    self.hataMesajı(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata Aldınız. Tekrar Deneyiniz!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            hataMesajı(titleInput: "Hata!", messageInput: "Email ve Parola giriniz!")
        }
        
    }
    
    func hataMesajı (titleInput: String,messageInput: String ){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
    
}

