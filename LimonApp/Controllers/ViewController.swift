//
//  ViewController.swift
//  LimonApp
//
//  Created by Turan Çabuk on 10.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //    var viewModel: MainViewModel = MainViewModel()
    //    var dataSource: [AllService] = []
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        setupTableView()
        //    }
        //    private func setupTableView() {
        //        mainTableView.delegate = self
        //        mainTableView.dataSource = self
    }
    //    private func setupCollectionView() {
    //        mainCollectionView.delegate = self
    //        mainCollectionView.dataSource = self
    //
    //        let collectionViewLayout = UICollectionViewFlowLayout()
    //        collectionViewLayout.scrollDirection = .horizontal
    //        collectionViewLayout.itemSize = CGSize(width: 200, height: 200)
    //        mainCollectionView.collectionViewLayout = collectionViewLayout
    //
    //        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
    //        mainCollectionView?.register(nib, forCellWithReuseIdentifier: "MainCollectionViewID")
    
    //    }
    
    
    //}
    //extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //
    //        return 10
    //    }
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //
    //        return 1
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    //
    //    }
    //
    //
    //}
    //extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //
    ////        return viewModel.employmentList.count
    //
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewID", for: indexPath) as! MainCollectionViewCell
    ////        let item = viewModel.serviceNameArray[indexPath.item]
    ////        let allService = AllService(name: viewModel.serviceNameArray[indexPath.item])
    ////        cell.configCollection(model: allService)
    //        return cell
    //    }
    //}
    //
    //
}
