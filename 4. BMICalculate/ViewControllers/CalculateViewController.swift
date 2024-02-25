//
//  CalculateViewController.swift
//  4. BMICalculate
//
//  Created by Семен Шевчик on 08.02.2024.
//

import UIKit

class CalculateViewController: UIViewController {
    
    // MARK: - UI

    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "calculate_background")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var mainStackView = UIStackView()
    
    private var heightStackView = UIStackView()
    private let heihgtTitleLable = UILabel(alignment: .left)
    private let heihgtNumberLable = UILabel(alignment: .right)
    private let heightSlider = UISlider(maxValue: 3)
    
    private var weightStackView = UIStackView()
    private let weightTitleLable = UILabel(alignment: .left)
    private let weightNumberLable = UILabel(alignment: .right)
    private let weightSlider = UISlider(maxValue: 200)
    
    private lazy var titleLable: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 40, weight: .bold)
        element.textColor = .darkGray
        element.textAlignment = .left
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let calculateButtom = UIButton(isBackgroundWhite: false)
    
    // MARK: - Private Properties
    
    private var calculatorBrain = CalculateBrain()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }

    private func setViews() {
        
        heightStackView = UIStackView(
            axis: .horizontal,
            distribution: .fillProportionally,
            subViews: [heihgtTitleLable, heihgtNumberLable]
        )
        
        weightStackView = UIStackView(
            axis: .horizontal,
            distribution: .fillProportionally,
            subViews: [weightTitleLable, weightNumberLable]
        )
        
        mainStackView = UIStackView(
            axis: .vertical,
            distribution: .fillProportionally,
            subViews: [
                titleLable,
                heightStackView,
                heightSlider,
                weightStackView,
                weightSlider,
                calculateButtom
            ]
        )
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        titleLable.text = "CALCULATE YOUR BMI"
        
        heihgtTitleLable.text = "Height"
        heihgtNumberLable.text = "1.50 m"
        
        weightTitleLable.text = "Weight"
        weightNumberLable.text = "100 kg"
        
        calculateButtom.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        
        heightSlider.addTarget(self, action: #selector(heightSliderChanged), for: .valueChanged)
        
        weightSlider.addTarget(self, action: #selector(weightSliderChanged), for: .valueChanged)
        
    }
    
    

    @objc private func calculateButtonTapped() {
        
        let height = heightSlider.value
        let weight = weightSlider.value
        
        calculatorBrain.calculateBMI(height: height, weight: weight)
        
        let resultVC = ResultViewController()
        
        resultVC.modalTransitionStyle = .flipHorizontal
        resultVC.modalPresentationStyle = .fullScreen
        
        resultVC.bmiValue = calculatorBrain.getBMIValue()
        resultVC.advice = calculatorBrain.getAdvice()
        resultVC.color = calculatorBrain.getColor()
        
        present(resultVC, animated: true)
    }
    
    @objc private func heightSliderChanged(_ sender: UISlider) {
        heihgtNumberLable.text = String(format: "%.2f", sender.value) + " m"
    }
    @objc private func weightSliderChanged(_ sender: UISlider) {
        weightNumberLable.text = String(format: "%.0f", sender.value) + " kg"
    }
    
}
// MARK: - Set Views and Constraints

extension CalculateViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            heightStackView.heightAnchor.constraint(equalToConstant: 21),
            heightSlider.heightAnchor.constraint(equalToConstant: 60),
            
            weightStackView.heightAnchor.constraint(equalToConstant: 21),
            weightSlider.heightAnchor.constraint(equalToConstant: 60),
            
            calculateButtom.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
}



