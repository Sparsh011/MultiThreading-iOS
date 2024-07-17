//
//  DebouncingVC.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import UIKit
import RxSwift
import Shimmer

class DebouncingVC: UIViewController, UIGestureRecognizerDelegate {
    let searchBar = DebouncingSearchBar()
    var debouncingDispatchItem: DispatchWorkItem?
    var debouncingViewModel = DebouncingViewModel()
    let disposeBag = DisposeBag()
    var recipes: [Recipe] = []
    var responseCollectionView: DebouncingCollectionView?
    var shimmerCollectionView: DishCellShimmerCollectionView?
    var responseDataSource = CollectionViewDataSource()
    var shimmerDatasource = DishCellShimmerCollectionViewDataSource()
    var errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}
