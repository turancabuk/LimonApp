//
//  MainViewController.swift
//  LimonApp
//
//  Created by Turan Çabuk on 10.02.2023.
//

import UIKit
import AVKit
import AVFoundation

class MainViewController: UIViewController {
    
    
    
    var viewModel: MainViewModel!
    let playerController = AVPlayerViewController()
    
    
    @IBOutlet weak var discountImageView: UIImageView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var postsCollectionView: UICollectionView!
 
    let vc = DetailsViewController()
    
    var test = 1
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
        let vc = DetailsViewController()
        
        
        playVideo()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        
        
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
        viewModel.serviceID = dugunID
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
                viewModel.serviceID = viewModel.serviceList[indexPath.row].service_id
                performSegue(withIdentifier: "toDetailsVC", sender: nil)
                
                
            case self.popularCollectionView:
                viewModel.serviceID = viewModel.popularList[indexPath.row].service_id
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedServiceID = viewModel.serviceID,
           let detailsViewController = segue.destination as? DetailsViewController {
            detailsViewController.serviceID = selectedServiceID
        }
    }
}
extension MainViewController {
     func playVideo() {
        
        guard let path = Bundle.main.path(forResource: "video-team", ofType: "mp4") else {
            debugPrint("video is not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        playerController.showsPlaybackControls = false
        playerController.player = player
        playerController.videoGravity = .resizeAspectFill
        

        
        present(playerController, animated: true) {
            player.play()
        }
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Method, video is finished")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainVC") as? MainViewController else {
            return
        }
        self.navigationController?.pushViewController(mainVC, animated: true)


    }
    
}
