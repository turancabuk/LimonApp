//
//  ServiceCollectionViewCell.swift
//  LimonApp
//
//  Created by Turan Çabuk on 15.02.2023.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    let serviceNameArray: [String:String] = [
        "Tadilat": "tadilat",
        "Temizlik": "temizlik",
        "Nakliyat": "nakliyat",
        "Tamir": "tamir",
        "Özel Ders": "ozel_ders",
        "Sağlık Eğitimi": "saglik",
        "Düğün Organizasyonu": "dugun",
        "Diğer": "diger"
    ]
    
    public func configureCell(withServiceInfo serviceInfo: Service) {
        guard let imageName = serviceNameArray["\(serviceInfo.name)"] else {
            return
        }
        serviceImageView.image = UIImage(named: "\(imageName)")
        serviceNameLabel.text = serviceInfo.name
    }
}
