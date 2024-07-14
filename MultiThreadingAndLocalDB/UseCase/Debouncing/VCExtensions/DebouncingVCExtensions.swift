//
//  DebouncingVCExtensions.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import RxSwift
import UIKit

/// All targets are set inside this extension
extension DebouncingVC {
    func dismissKeyboardOnScreenTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}

/// Contains implementation of targets
extension DebouncingVC {
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

/// Contains debouncing logic
extension DebouncingVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Handle text changes here
        
        if debouncingDispatchItem != nil {
            debouncingDispatchItem?.cancel()
            debouncingDispatchItem = nil
        }
        
        debouncingDispatchItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            self.makeApiCallWithSearchQuery()
        }
        
        // Execute the work item after a delay of 0.8 seconds
        if let workItem = debouncingDispatchItem {
            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.8, execute: workItem)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

/// Initialize and add views to the VC
extension DebouncingVC {
    func configure() {
        setupViews()
        setupBindings()
    }
    
    private func setupViews() {
        initializeViews()
        addViews()
        setCustomPropertiesAndDelegates()
        setupConstraints()
        addTargets()
    }
    
    private func setupBindings() {
        debouncingViewModel.recipes
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] recipes in
                self?.populateRecipes(recipes)
            })
            .disposed(by: disposeBag)
        
        debouncingViewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] errorMessage in
                self?.configureErrorFromApiWith(errorMessage: errorMessage)
            })
            .disposed(by: disposeBag)
    }
    
    private func initializeViews() {
        collectionView = DebouncingCollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    }
    
    private func addViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView!)
    }
    
    private func setCustomPropertiesAndDelegates() {
        searchBar.delegate = self
        collectionView?.dataSource = dataSource
        collectionView?.register(DishCell.self, forCellWithReuseIdentifier: DishCell.reuseIdentifier)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20)
        ])
        
        collectionView?.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 10).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    private func addTargets() {
        dismissKeyboardOnScreenTap()
    }
}


/// Create layout for collection view
extension DebouncingVC {
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(20)
        group.interItemSpacing = .flexible(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 5, bottom: 30, trailing: 5)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}


/// Handle API calls and their responses
extension DebouncingVC {
    func makeApiCallWithSearchQuery() {
        DispatchQueue.main.async {
            let searchQuery: String = self.searchBar.searchTextField.text ?? ""
            
            if searchQuery.isEmpty {
                return
            }
            
            let baseUrl = NetworkConstants.SpoonacularBaseurl.rawValue
            let apiRoute = NetworkConstants.SpoonacularSearchApiRoute.rawValue
            let requestParams: [String: Any] = [
                "query": searchQuery,
                "apiKey": NetworkConstants.SpoonacularApiKey.rawValue
            ]
            
            self.debouncingViewModel.fetchRecipes(
                baseUrl: baseUrl,
                apiRoute: apiRoute,
                withSearchQuery: searchQuery,
                requestParams: requestParams
            )
        }
    }
    
    private func mapRecipesToDataSource(from recipes: [Recipe]) -> [CollectionViewData] {
        var newData: [CollectionViewData] = []
        
        for recipe in recipes {
            newData.append(CollectionViewData(title: recipe.title, imageUrl: recipe.image, dishId: recipe.id))
        }
        
        return newData
    }
    
    private func configureErrorFromApiWith(errorMessage: String) {
        self.collectionView?.removeFromSuperview()
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        errorView.setErrorMessage(errorMessage)
    }
    
    private func populateRecipes(_ recipes: [Recipe]) {
        if recipes.count == 0 {
            configureErrorFromApiWith(errorMessage: "No result found.")
            return
        }
        
        guard let collectionView = collectionView else {
            return
        }
        
        errorView.removeFromSuperview()
        view.addSubview(collectionView)
        
        self.recipes = recipes
        let newData = self.mapRecipesToDataSource(from: recipes)
        dataSource.data = newData
        collectionView.reloadData()
    }
}
