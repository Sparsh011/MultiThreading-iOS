//
//  TwoColumnsListView.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 14/07/24.
//

import UIKit

class DebouncingCollectionView: UICollectionView {
    
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
