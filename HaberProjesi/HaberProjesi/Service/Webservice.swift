//
//  Webservice.swift
//  HaberProjesi
//
//  Created by Ömer Yasir Önal on 28.02.2024.
//

import Foundation

class Webservice {
    
    func haberleriIndir(url: URL, completionHandler: @escaping ([News]?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completionHandler(nil)
            } else if let data = data {
                let haberlerDizisi = try? JSONDecoder().decode([News].self, from: data)
                
                if let haberlerDizisi = haberlerDizisi {
                    completionHandler(haberlerDizisi)
                }
            }
        }.resume()
    }
}
