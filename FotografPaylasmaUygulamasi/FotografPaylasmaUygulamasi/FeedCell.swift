//
//  FeedCell.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Ömer Yasir Önal on 26.02.2024.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var yorumLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
