//
//  MainViewController.swift
//  LimonApp
//
//  Created by Turan Çabuk on 10.02.2023.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var viewModel: MainViewModel!
    
    @IBOutlet weak var discountImageView: UIImageView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webservice = MainWebservice()
        viewModel = MainViewModel(webservice: webservice)
        navigationItem.title = "Armut App Case"
        
        
        
        
        
        
        
        
        
        viewModel.fetchMainModel { [weak self] result in
            switch result {
            case .success(let mainModel):
                DispatchQueue.main.async {
                    self?.assignDelegates()
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
        func didSelectService(serviceID: Int) {
            viewModel.selectedServiceID = serviceID
            viewModel.fetchServiceModel { [weak self] result in
                switch result {
                case .success(let service):
                    self?.assignDelegates()
                case .failure(let error):
                    print("error")
                }
            }
        }
    }
    private func assignDelegates() {
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        
        discountImageView.isUserInteractionEnabled = true
        let tapGastureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedDiscountView))
        discountImageView.addGestureRecognizer(tapGastureRecognizer)
    }
    @objc func tappedDiscountView() {
        let dugunID = 59
        ServiceInfoModel.shared.choosenServiceID = dugunID
        performSegue(withIdentifier: "toServiceDetailsVC", sender: nil)
    }
}
