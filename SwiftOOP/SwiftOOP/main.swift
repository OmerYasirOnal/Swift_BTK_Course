//
//  main.swift
//  SwiftOOP
//
//  Created by Ömer Yasir Önal on 15.02.2024.
//

import Foundation

let yasir = Kullanici(isim: "Yasir", yas: 20, meslek: "Yazılım", tip: .AdminKullanici)

let murat = OzelKullanici(isim: "Murat", yas: 20, meslek: "Öğretmen", tip: .NormalKullanici)


murat.yeniFonksiyon()
murat.ornekFonskiyon()
print(yasir.tip)
