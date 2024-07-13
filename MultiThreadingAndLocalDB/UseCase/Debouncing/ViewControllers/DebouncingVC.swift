//
//  DebouncingVC.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import UIKit

class DebouncingVC: UIViewController, UIGestureRecognizerDelegate {
    private let searchBar = DebouncingSearchBar()
    var debouncingDispatchItem: DispatchWorkItem?
    private var debouncingViewModel = DebouncingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        addTargets()
    }
    
    private func setupViews() {
        addViews()
        setCustomPropertiesAndDelegates()
    }
    
    private func addViews() {
        view.addSubview(searchBar)
    }
    
    private func setCustomPropertiesAndDelegates() {
        searchBar.delegate = self
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func addTargets() {
        dismissKeyboardOnScreenTap()
    }
    
    func makeApiCallWithSearchQuery() {
        let searchQuery: String = searchBar.searchTextField.text ?? ""
        debouncingViewModel.makeApiCall(withSearchQuery: searchQuery)
    }
}
