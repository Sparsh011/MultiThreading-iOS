//
//  DebouncingSearchBar.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import UIKit

class DebouncingSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = "Type here..."
        
        self.backgroundImage = UIImage() // Removes default background
        self.searchTextField.backgroundColor = UIColor.systemGray5 // Background color of the search field
        self.searchTextField.layer.cornerRadius = 10
        self.searchTextField.layer.masksToBounds = true
        
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(
                string: "Type here...",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            )
        }
    }
    
    func setCustomProperties(
        backgroundColor: UIColor = UIColor.systemGray5,
        cornerRadius: CGFloat = 10,
        fontSize: CGFloat = 16,
        placeholder: String = "Type here..."
    ) {
        
        if self.searchTextField.backgroundColor != backgroundColor {
            self.searchTextField.backgroundColor = backgroundColor
        }

        if self.searchTextField.layer.cornerRadius != cornerRadius {
            self.searchTextField.layer.cornerRadius = cornerRadius
        }

        if self.searchTextField.font?.pointSize != fontSize {
            self.searchTextField.font = UIFont.systemFont(ofSize: fontSize)
        }

        if self.searchTextField.attributedPlaceholder?.string != placeholder ||
           self.searchTextField.attributedPlaceholder?.attribute(.font, at: 0, effectiveRange: nil) as? UIFont != UIFont.systemFont(ofSize: fontSize) {
            self.searchTextField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)
                ]
            )
        }
    }
}
