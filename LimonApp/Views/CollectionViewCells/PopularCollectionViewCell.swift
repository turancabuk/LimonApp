//
//  PopularCollectionViewCell.swift
//  LimonApp
//
//  Created by Turan Çabuk on 15.02.2023.
//

import UIKit
import SDWebImage

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var popularImageView: UIImageView!
    @IBOutlet weak var popularTitle: UILabel!
    
    
    
    //    @IBOutlet weak var popularImageView: UIImageView!
//    @IBOutlet weak var popularTitle: UILabel!
    
    public func configureCell(withPopularInfo popularInfo: Popular) {
        DispatchQueue.main.async {
            self.popularImageView.sd_setImage(with: URL(string: popularInfo.image_url))
        }
        popularTitle.text = popularInfo.name
    }
}
