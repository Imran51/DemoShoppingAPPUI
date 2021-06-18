//
//  ViewController.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 14/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let clickToViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Click To View", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemTeal
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(clickToViewButton)
        setViewConstraint()
        clickToViewButton.addTarget(self, action: #selector(showDetailScreen(_:)), for: .touchUpInside)
    }

    private func setViewConstraint() {
        NSLayoutConstraint.activate([
            clickToViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickToViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            clickToViewButton.widthAnchor.constraint(equalToConstant: 150),
            clickToViewButton.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    @objc private func showDetailScreen(_ sender: UIButton) {
        let itemsView = ItemViewController()
        itemsView.title = "Items View"
        navigationController?.pushViewController(itemsView, animated: true)
    }

}

