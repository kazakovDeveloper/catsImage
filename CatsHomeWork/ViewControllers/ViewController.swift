//
//  ViewController.swift
//  CatsHomeWork
//
//  Created by Kazakov Danil on 08.11.2022.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var viewModels = [CatsCollectionViewCellViewModel]()
    
    //MARK: collectionView
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/2)-4,
                                 height: (view.frame.size.width/2)-4)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = view.bounds
        collectionView.register(CustomCollectionViewCell.self,
                                forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        navigationItem.title = "Cats"
        
        fetchData()
    
    }
    
    
    func fetchData() {
        NetworkManager.shared.getAllCatData { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap({

                    return CatsCollectionViewCellViewModel(
                        name: $0.breeds?.first?.name ?? "",
                        photo: $0.url ?? "",
                        description: $0.breeds?.first?.description ?? ""
                    )
                })
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error \(error)")
            }
        }
        
    }
    
    //MARK: - Setup Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.identifier,
            for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        let currentURL = viewModels[indexPath.row].photo
        
        detailVC.catDescription.text = viewModels[indexPath.row].description
        
        NetworkManager.shared.fetchImage(from: currentURL, completion: { result in
            switch result {
            case .success(let catImage):
                detailVC.catImage.image = UIImage(data: catImage)
            case .failure(let error):
                print("Error \(error)")
            }
        })
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

