//
//  DishCellShimmerView.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 16/07/24.
//

import UIKit
import Shimmer

class DishCellShimmerViewCell: UICollectionViewCell {
    static let reuseIdentifier = "dish-cell-shimmer-reuse-identifier"
    let parentShimmerView: FBShimmeringView = {
       let view = FBShimmeringView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titlePlaceholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 10
        return view
    }()
    
    let imagePlaceholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 20
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DishCellShimmerViewCell {
    func configure() {
        self.contentView.addSubview(parentShimmerView)
        containerView.addSubview(imagePlaceholder)
        containerView.addSubview(titlePlaceholder)
        
        parentShimmerView.contentView = containerView
        
        NSLayoutConstraint.activate([
            parentShimmerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            parentShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parentShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parentShimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imagePlaceholder.topAnchor.constraint(equalTo: containerView.topAnchor),
            imagePlaceholder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePlaceholder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePlaceholder.heightAnchor.constraint(equalToConstant: 150),
            
            titlePlaceholder.topAnchor.constraint(equalTo: imagePlaceholder.bottomAnchor, constant: 20),
            titlePlaceholder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePlaceholder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titlePlaceholder.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        parentShimmerView.isShimmering = true
    }
}


class DishCellShimmerCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

class DishCellShimmerCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCellShimmerViewCell.reuseIdentifier, for: indexPath) as? DishCellShimmerViewCell else {
            fatalError("Failed to dequeue a Collection Cell.")
        }
        
        return cell
    }
}
