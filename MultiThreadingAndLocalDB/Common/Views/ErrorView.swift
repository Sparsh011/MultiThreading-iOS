//
//  ErrorView.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 15/07/24.
//

import UIKit
import Lottie

class ErrorView: UIView {
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let lottieView: LottieAnimationView = {
        let view = LottieAnimationView(name: "error-anim")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// This extension is used to populate the views inside the parent UIView
extension ErrorView {
    private func configure() {
        addTargetsAndTapGestures()
        addViews()
    }
    
    private func addTargetsAndTapGestures() {
        
    }
    
    private func addViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(errorLabel)
        self.addSubview(lottieView)
        
        self.errorLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            lottieView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            lottieView.widthAnchor.constraint(equalToConstant: 150),
            lottieView.heightAnchor.constraint(equalToConstant: 150),
            lottieView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }
    
    public func setErrorMessage(_ message: String) {
        self.errorLabel.text = message
        self.lottieView.play()
    }
}
