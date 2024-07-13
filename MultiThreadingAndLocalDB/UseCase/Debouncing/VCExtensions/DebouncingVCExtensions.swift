//
//  DebouncingVCExtensions.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import Foundation
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
    
    func random() -> UIColor {
            let red = CGFloat(arc4random_uniform(256)) / 255.0
            let green = CGFloat(arc4random_uniform(256)) / 255.0
            let blue = CGFloat(arc4random_uniform(256)) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
}
