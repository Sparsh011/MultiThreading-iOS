//
//  DebouncingVC.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import UIKit

class DebouncingVC: UIViewController, UIGestureRecognizerDelegate {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Type here..."
        
        // Customize appearance
        searchBar.backgroundImage = UIImage() // Removes default background
        searchBar.searchTextField.backgroundColor = UIColor.systemGray5 // Background color of the search field
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.masksToBounds = true
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(
                string: "Type here...",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            )
        }
        
        return searchBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        
        if let navigationController = navigationController {
            navigationController.interactivePopGestureRecognizer?.delegate = self
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20)
        ])
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension DebouncingVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Handle text changes here
        print("Text changed: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Handle the return button press
        searchBar.resignFirstResponder()
        print("Search button clicked")
    }
}
