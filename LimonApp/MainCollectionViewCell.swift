//
//  MainCollectionViewCell.swift
//  LimonApp
//
//  Created by Turan Çabuk on 11.02.2023.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    @IBOutlet weak var ServiceImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var nearYouLabel: UILabel!

    
    static let identifier = String(describing: MainCollectionViewCell.self)
   
    
}
