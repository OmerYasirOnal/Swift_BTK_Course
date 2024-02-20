//
//  Sehir.swift
//  SehirTanitimKitabi
//
//  Created by Ömer Yasir Önal on 16.02.2024.
//

import Foundation
import UIKit

class Sehir {
    
    var isim : String
    var bolge : String
    var gorsel : UIImage
    
    init(isim: String, bolge: String, gorsel: UIImage) {
        self.isim = isim
        self.bolge = bolge
        self.gorsel = gorsel
    }
}
