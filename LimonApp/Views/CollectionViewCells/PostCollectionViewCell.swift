//
//  PostCollectionViewCell.swift
//  LimonApp
//
//  Created by Turan Çabuk on 15.02.2023.
//

import UIKit
import SDWebImage

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postsImageView: UIImageView!
    @IBOutlet weak var postsBlogCategory: UILabel!
    @IBOutlet weak var postsTitle: UILabel!

    public func configureCell(withPostInfo postInfo: Post) {
        DispatchQueue.main.async {
            self.postsImageView.sd_setImage(with: URL(string: postInfo.image_url))
        }
        postsBlogCategory.text = postInfo.category
        postsTitle.text = postInfo.title
    }
}
