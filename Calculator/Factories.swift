//
//  Factories.swift
//  Calculator
//
//  Created by Renat Nazyrov on 17.08.2023.
//  Copyright © 2023 London App Brewery. All rights reserved.
//

import UIKit

func makeButton(withText title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 90)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .gray
    button.titleLabel?.numberOfLines = 1
    
    return button
}

func createStackView() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    
    return stackView
}

func createLabel() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.textAlignment = .right
    label.backgroundColor = .gray
    label.font = UIFont.systemFont(ofSize: 100)
    label.text = " "
    label.adjustsFontSizeToFitWidth = true

    return label
}
