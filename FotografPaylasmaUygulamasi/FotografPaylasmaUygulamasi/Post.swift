//
//  Post.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Ömer Yasir Önal on 27.02.2024.
//

import Foundation

class Post{
    var email = ""
    var yorum = ""
    var gorselurl = ""
    
    init(email: String = "", yorum: String = "", gorselurl: String = "") {
        self.email = email
        self.yorum = yorum
        self.gorselurl = gorselurl
    }
}
