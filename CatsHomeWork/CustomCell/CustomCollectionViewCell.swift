//
//  CustomCollectionViewCell.swift
//  CatsHomeWork
//
//  Created by Kazakov Danil on 08.11.2022.
//

import UIKit

struct CatsCollectionViewCellViewModel {
    let name: String
    let photo: String
    let description: String
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    
    //MARK: - Elements
    
    private let catImageView: UIImageView = {
        let catImageView = UIImageView()
        catImageView.contentMode = .scaleToFill
        catImageView.layer.cornerRadius = 10
        catImageView.clipsToBounds = true
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        catImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return catImageView
        
    }()
    
    private let myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        myLabel.layer.cornerRadius = 10
        myLabel.backgroundColor = .gray
        myLabel.clipsToBounds = true
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return myLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(catImageView)
        contentView.addSubview(myLabel)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(label: String) {
        myLabel.text = label
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    func configure(with viewModel: CatsCollectionViewCellViewModel) {
        
        myLabel.text = "Порода: \(viewModel.name)"
        
        NetworkManager.shared.fetchImage(from: viewModel.photo) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.catImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Constraints for elements in Cell
    override func updateConstraints() {
        super.updateConstraints()
        //MARK: - myLabel constraints
        NSLayoutConstraint.activate([
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            myLabel.leftAnchor.constraint(equalTo: catImageView.leftAnchor, constant: 0),
            myLabel.rightAnchor.constraint(equalTo: catImageView.rightAnchor, constant: 0),
        ])
        //MARK: - catImage constraints
        NSLayoutConstraint.activate([
            catImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            catImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            catImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            catImageView.bottomAnchor.constraint(equalTo: myLabel.topAnchor, constant: -1),
        ])
    }
    
}
