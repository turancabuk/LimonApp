//
//  MainViewController.swift
//  LimonApp
//
//  Created by Turan Çabuk on 10.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
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
        
        
        
        
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        
        
        assignDelegates()
        
        viewModel.fetchMainModel { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.serviceCollectionView.reloadData()
                    self?.popularCollectionView.reloadData()
                    self?.postsCollectionView.reloadData()
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
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
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let viewModel = self.viewModel {
            switch collectionView {
            case self.serviceCollectionView:
                return viewModel.serviceList.count
            case self.popularCollectionView:
                return viewModel.popularList.count
            case self.postsCollectionView:
                return viewModel.postList.count
            default:
                return 0
            }
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let viewModel = viewModel {
            switch collectionView {
            case self.serviceCollectionView:
                guard let serviceList = viewModel.serviceList[indexPath.row] as? Service else {
                    return UICollectionViewCell()
                }
                let serviceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCellID", for: indexPath) as! ServiceCollectionViewCell
                serviceCell.configureCell(withServiceInfo: serviceList)
                return serviceCell
            case self.popularCollectionView:
                guard let popularList = viewModel.popularList[indexPath.row] as? Popular else {
                    return UICollectionViewCell()
                }
                let popularCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCellID", for: indexPath) as! PopularCollectionViewCell
                popularCell.configureCell(withPopularInfo: popularList)
                return popularCell
            case self.postsCollectionView:
                guard let postList = viewModel.postList[indexPath.row] as? Post else {
                    return UICollectionViewCell()
                }
                let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCellID", for: indexPath) as! PostCollectionViewCell
                postCell.configureCell(withPostInfo: postList)
                return postCell
            default:
                return UICollectionViewCell()
            }
        }else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let viewModel = viewModel {
            switch collectionView {
            case self.serviceCollectionView:
                let vc = DetailsViewController()
//                viewModel.selectedServiceID = viewModel.serviceList[indexPath.row].service_id
                vc.serviceID = viewModel.serviceList[indexPath.row].service_id
//                ServiceInfoModel.shared.choosenServiceID = viewModel.serviceList[indexPath.row].service_id
//                navigationController?.pushViewController(vc, animated: true)
                performSegue(withIdentifier: "toDetailsVC", sender: nil)
            case self.popularCollectionView:
                viewModel.selectedServiceID = viewModel.popularList[indexPath.row].service_id
                DetailsViewController().serviceID = viewModel.serviceList[indexPath.row].service_id
                ServiceInfoModel.shared.choosenServiceID = viewModel.popularList[indexPath.row].service_id
                performSegue(withIdentifier: "toDetailsVC", sender: nil)
            case self.postsCollectionView:
                let link = viewModel.postList[indexPath.row].link
                if let url = URL(string: link) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }else{
                        UIApplication.shared.openURL(url)
                    }
                }
            default:
                print("error")
            }
        }
    }
}
