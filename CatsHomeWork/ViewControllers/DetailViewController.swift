//
//  DetailViewController.swift
//  CatsHomeWork
//
//  Created by Kazakov Danil on 08.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    lazy var catImage: UIImageView = {
        var catImage = UIImageView()
        catImage.contentMode = .scaleToFill
        catImage.clipsToBounds = true
        
        catImage.translatesAutoresizingMaskIntoConstraints = false
    
        return catImage
    }()
    
    lazy var catDescription: UILabel = {
        let catDescription = UILabel()
        catDescription.numberOfLines = 0
        catDescription.textAlignment = .center
        catDescription.font = .systemFont(ofSize: 19, weight: .bold)
        
        
        catDescription.translatesAutoresizingMaskIntoConstraints = false
        return catDescription
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(catImage)
        view.addSubview(catDescription)
        
        navigationItem.title = "Details about cat"
        view.backgroundColor = .systemBackground
    }
    
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        NSLayoutConstraint.activate([
            catImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            catImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            catImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            catImage.bottomAnchor.constraint(equalTo: catDescription.topAnchor, constant: 0)
            
        ])
        
        NSLayoutConstraint.activate([
            catDescription.leftAnchor.constraint(equalTo: catImage.leftAnchor),
            catDescription.rightAnchor.constraint(equalTo: catImage.rightAnchor),
            catDescription.topAnchor.constraint(equalTo: catImage.bottomAnchor, constant: 0),
            catDescription.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
        
    }

}
