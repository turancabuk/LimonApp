//
//  ViewController.swift
//  LimonApp
//
//  Created by Turan Çabuk on 10.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: MainViewModel!
    
    @IBOutlet weak var discountImageView: UIImageView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webservice = MainWebservice()
        viewModel = MainViewModel(webservice: webservice)
        
        viewModel.fetchMainModel { [weak self] result in
            switch result {
            case .success(let mainModel):
                DispatchQueue.main.async {
                    
                }
            case .failure(let error):
                print("error")
            }
        }
        func didSelectService(serviceID: Int) {
            viewModel.selectedServiceID = serviceID
            viewModel.fetchServiceModel { [weak self] result in
                switch result {
                case .success(let service):
                    print("succes")
                case .failure(let error):
                    print("error")
                }
                
            }
        }
    }
}
