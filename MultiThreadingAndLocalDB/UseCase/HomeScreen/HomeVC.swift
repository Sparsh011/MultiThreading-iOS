//
//  ViewController.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 10/07/24
//

import UIKit

class HomeVC: UIViewController {
    var workItem: DispatchWorkItem?
    var timer: Timer?
    var cancellingWorkTimer: Timer?
    
    private let navigateToDebouncingVC: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Navigate to Debouncing VC", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setTargets()
    }
    
    private func setupViews() {
        view.addSubview(navigateToDebouncingVC)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            navigateToDebouncingVC.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            navigateToDebouncingVC.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setTargets() {
        navigateToDebouncingVC.addTarget(self, action: #selector(onNavigateToDebouncingVCClick), for: .touchUpInside)
    }
    
    @objc private func onNavigateToDebouncingVCClick() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DebouncingVC") as! DebouncingVC
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func checkWorkItem() {
        if workItem?.isCancelled == true {
            print("Work item was cancelled, updating UI to blue")
            self.view.backgroundColor = .blue
        } else {
            print("Work item was not cancelled")
        }
    }
}

extension HomeVC {
    
    private func playWithDispatchWorkItem() {
        view.backgroundColor = .brown
        // Create the work item
        workItem = DispatchWorkItem {
            [weak self] in
            guard let self = self else { return }
            
            if self.workItem?.isCancelled == true {
                print("Work item was cancelled")
                return
            }
            
            // Perform some task
            print("Performing task")
            // Update UI
            DispatchQueue.main.async {
                self.view.backgroundColor = .red
            }
        }
        
        // Execute the work item after a delay
        if let workItem = workItem {
            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 5, execute: workItem)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(checkWorkItem), userInfo: nil, repeats: false)
        cancellingWorkTimer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false, block: {_ in
            self.workItem?.cancel()
        })
    }
}
