//
//  Kullanici.swift
//  SwiftOOP
//
//  Created by Ömer Yasir Önal on 15.02.2024.
//

import Foundation

enum KullaniciTipi{
    case AdminKullanici
    case NormalKullanici
    case YetkisizKullanici
}

class Kullanici {
    var isim : String
    var yas : Int
    var meslek : String
    var tip : KullaniciTipi
    init(isim: String, yas: Int, meslek: String, tip: KullaniciTipi) {
        self.isim = isim
        self.yas = yas
        self.meslek = meslek
        self.tip = tip
    }
    
    func ornekFonskiyon() {
        print("Örnek Fonksiyon Çalıştırıldı")
    }
    
}
