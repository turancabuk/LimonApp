//  DetailsViewController.swift
//  LimonApp
//
//  Created by Turan Çabuk on 18.02.2023.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    var viewModel: MainViewModel!
    var serviceID: Int?
    
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var prosLabel: UILabel!
    @IBOutlet weak var avarageLabel: UILabel!
    @IBOutlet weak var lastMonthLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webservice = MainWebservice()
        viewModel = MainViewModel(webservice: webservice)


        viewModel.fetchServiceModel { [weak self] result in
            switch result {
            case .success(_):
                self?.configureDetailView()
            case .failure(_):
                print("HATA: JSONDAN")
            }
        }
        

    }
    func configureDetailView(){
        DispatchQueue.main.async {
            self.serviceNameLabel.text = self.viewModel.detailList[0].name
            self.prosLabel.text = "\(self.viewModel.detailList[0].pro_count ?? 0)"
            self.avarageLabel.text = "\(self.viewModel.detailList[0].average_rating ?? 0)"
            self.lastMonthLabel.text = "\(self.viewModel.detailList[0].completed_jobs_on_last_month ?? 0)"
            let url = self.self.viewModel.detailList[0].image_url!
            self.self.serviceImageView.sd_setImage(with: URL(string: url))
        }
    }
}
