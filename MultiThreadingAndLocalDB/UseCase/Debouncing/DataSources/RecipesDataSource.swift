//
//  RecipesDataSource.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 15/07/24.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var data: [CollectionViewData] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.reuseIdentifier, for: indexPath) as? DishCell else {
            fatalError("Failed to dequeue a Collection Cell.")
        }
        
        let item = data[indexPath.item]
        cell.dishImage.loadImage(from: URL(string: item.imageUrl)!)
        cell.dishTitle.text = item.title
        
        return cell
    }
}

struct CollectionViewData {
    let title: String
    let imageUrl: String
    let dishId: Int
}
