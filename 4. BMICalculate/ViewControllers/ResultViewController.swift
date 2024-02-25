//
//  ResultViewController.swift
//  4. BMICalculate
//
//  Created by Семен Шевчик on 08.02.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - UI

    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "result_background")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let titleLabel = UILabel(alignment: .left, ofSize: 35, weight: .bold)
    private let resultLabel = UILabel(alignment: .left, ofSize: 80, weight: .bold)
    private let descriptionLabel = UILabel(alignment: .left, ofSize: 20, weight: .light)
    
    private var mainStackView = UIStackView()
    
    private let recalculateButtom = UIButton(isBackgroundWhite: true)
    
    // MARK: - Public Properties
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }
    
    
    // MARK: - Set Views
    
    private func setViews() {
        
        resultLabel.text = bmiValue
        descriptionLabel.text = advice
        view.backgroundColor = color
        
        mainStackView = UIStackView(
            axis: .vertical,
            distribution: .fillProportionally,
            subViews: [
                titleLabel,
                resultLabel,
                descriptionLabel
            ]
        )
        
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        view.addSubview(recalculateButtom)
        
        recalculateButtom.addTarget(self, action: #selector(recalculateButtonTapped), for: .touchUpInside)
    }
    
    @objc private func recalculateButtonTapped() {
        dismiss(animated: true)
    }
}

extension ResultViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            recalculateButtom.heightAnchor.constraint(equalToConstant: 51),
            recalculateButtom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recalculateButtom.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recalculateButtom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}
