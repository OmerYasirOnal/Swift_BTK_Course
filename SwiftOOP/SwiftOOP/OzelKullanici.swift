//
//  OzelKullanici.swift
//  SwiftOOP
//
//  Created by Ömer Yasir Önal on 15.02.2024.
//

import Foundation

class OzelKullanici : Kullanici {
    
    func yeniFonksiyon() {
        print("Yeni fonksiyon çalıştı")
    }
    
    override func ornekFonskiyon() {
        super.ornekFonskiyon()
        print("Özel örnek fonksiyon çalıştıırldı")
    }
}
