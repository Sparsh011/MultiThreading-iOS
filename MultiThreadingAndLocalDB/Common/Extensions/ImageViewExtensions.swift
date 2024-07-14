//
//  ImageViewExtensions.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 15/07/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil else
            {
                print("Error fetching image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
