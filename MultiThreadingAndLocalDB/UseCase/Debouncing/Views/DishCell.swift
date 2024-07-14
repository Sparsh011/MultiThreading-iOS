//
//  DishCell.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 14/07/24.
//

import Foundation
import UIKit

class DishCell: UICollectionViewCell {
    static let reuseIdentifier = "food-cell-reuse-identifier"
    
    let dishTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dishImage = UIImageView()
    
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

extension DishCell {
    func configure() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        dishTitle.numberOfLines = 0
        
        dishImage.layer.masksToBounds = true
        dishImage.layer.cornerRadius = 30
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(dishImage)
        stackView.addArrangedSubview(dishTitle)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
