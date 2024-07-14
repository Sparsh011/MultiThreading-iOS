//
//  DebouncingVC.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import UIKit
import RxSwift

class DebouncingVC: UIViewController, UIGestureRecognizerDelegate {
    let searchBar = DebouncingSearchBar()
    var debouncingDispatchItem: DispatchWorkItem?
    var debouncingViewModel = DebouncingViewModel()
    let disposeBag = DisposeBag()
    var recipes: [Recipe] = []
    var collectionView: DebouncingCollectionView?
    var dataSource = CollectionViewDataSource()
    var errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}
