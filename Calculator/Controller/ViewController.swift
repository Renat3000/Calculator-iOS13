//  ViewController.swift
//  Calculator
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.

import UIKit

class ViewController: UIViewController {
    var outputField: UILabel
    var isFinishedTypingNumber: Bool = false
    var displayValue: Double {
        get {
            guard let number = Double(outputField.text!) else {
                return Double(0)
            }
            return number
        }
        set {
            if newValue == 0 {
                outputField.text = "0"
            } else {
//                displayLabel.text = String(newValue)
                outputField.text = String(newValue.withCommas())
            }
            
            if newValue.truncatingRemainder(dividingBy: 1) == 0 {
                outputField.text = String(Int(newValue))
            }
        }
    }
    
    
    init() {
        outputField = createLabel()
        outputField.text = " "
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
        view.addSubview(outputField)
        outputField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        outputField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        outputField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let zeroStack = createStackView()
        let buttonAC = makeButton(withText: "C")
        let buttonSign = makeButton(withText: "±")
        let buttonPercentage = makeButton(withText: "%")
        let buttonDivision = makeButton(withText: "÷")
        
        buttonAC.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        buttonSign.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        buttonPercentage.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        buttonDivision.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        
        zeroStack.addArrangedSubview(buttonAC)
        zeroStack.addArrangedSubview(buttonSign)
        zeroStack.addArrangedSubview(buttonPercentage)
        zeroStack.addArrangedSubview(buttonDivision)
        view.addSubview(zeroStack)
        
        zeroStack.topAnchor.constraint(equalTo: outputField.bottomAnchor, constant: 8).isActive = true
        zeroStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        zeroStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let firstStack = createStackView()
        let button7 = makeButton(withText: "7")
        let button8 = makeButton(withText: "8")
        let button9 = makeButton(withText: "9")
        let buttonMultiplication = makeButton(withText: "×")
        
        button7.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        button8.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        button9.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        buttonMultiplication.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        
        firstStack.addArrangedSubview(button7)
        firstStack.addArrangedSubview(button8)
        firstStack.addArrangedSubview(button9)
        firstStack.addArrangedSubview(buttonMultiplication)
        view.addSubview(firstStack)
        
        firstStack.topAnchor.constraint(equalTo: zeroStack.bottomAnchor, constant: 8).isActive = true
        firstStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        firstStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let secondStack = createStackView()
        let button4 = makeButton(withText: "4")
        let button5 = makeButton(withText: "5")
        let button6 = makeButton(withText: "6")
        let buttonMinus = makeButton(withText: "–")
        
        button4.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        button5.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        button6.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        buttonMinus.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        
        secondStack.addArrangedSubview(button4)
        secondStack.addArrangedSubview(button5)
        secondStack.addArrangedSubview(button6)
        secondStack.addArrangedSubview(buttonMinus)
        view.addSubview(secondStack)
        
        secondStack.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 8).isActive = true
        secondStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        secondStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let thirdStack = createStackView()
        let button1 = makeButton(withText: "1")
        let button2 = makeButton(withText: "2")
        let button3 = makeButton(withText: "3")
        let buttonPlus = makeButton(withText: "+")
        
        button1.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        buttonPlus.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        
        thirdStack.addArrangedSubview(button1)
        thirdStack.addArrangedSubview(button2)
        thirdStack.addArrangedSubview(button3)
        thirdStack.addArrangedSubview(buttonPlus)
        view.addSubview(thirdStack)
        
        thirdStack.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 8).isActive = true
        thirdStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        thirdStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let fourthStack = createStackView()
        
        let buttonComma = makeButton(withText: ".")
        let button0 = makeButton(withText: "0")
        let buttonEquals = makeButton(withText: "=")
        
        button0.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        buttonEquals.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        buttonComma.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        
        fourthStack.addArrangedSubview(button0)
        fourthStack.addArrangedSubview(buttonComma)
        fourthStack.addArrangedSubview(buttonEquals)
        view.addSubview(fourthStack)
        
        fourthStack.topAnchor.constraint(equalTo: thirdStack.bottomAnchor, constant: 8).isActive = true
        fourthStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fourthStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //три проблемые строки ниже, которые создают ошибки в терминале из-за constraints
//        button0.widthAnchor.constraint(equalTo: fourthStack.widthAnchor, multiplier: 0.49).isActive = true
//        buttonComma.widthAnchor.constraint(equalTo: fourthStack.widthAnchor, multiplier: 0.24).isActive = true
//        buttonEquals.widthAnchor.constraint(equalTo: fourthStack.widthAnchor, multiplier: 0.235).isActive = true
    }
    //    var clearButton: UIButton!
    
    private var calculator = CalculatorLogic()
    @objc func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            if calcMethod == "C" {
//          clearButton.setTitle("AC", for: .normal)
            }
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }
    
//    @objc func numPressed(_ sender: UIButton) {
//        //What should happen when a non-number button is pressed
//        isFinishedTypingNumber = false
//
//        if let numValue = sender.currentTitle {
//            outputField.text?.append(numValue)
//        }
//    }
            
    @objc func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        //замена AC на C. всрато, но работает. ругается что "Comparing non-optional value of type 'Double' to 'nil' always returns true"
        if displayValue != nil {
//            clearButton.setTitle("C", for: .normal)
        }
// вообще, мы можем ограничиться displayLabel.text = sender.currentTitle, но currentTitle у нас String? то есть нужно блять как то его проверить, поэтому через if let проверяем что currenTitle не пустой
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber == true {
                
                //бэкспэйс засунул сюда
                if numValue == "←" {
                    if outputField.text!.count > 1 {
                        outputField.text?.removeLast()
                    } else {
                        displayValue = Double(0)
                    }
                
                } else {
                    outputField.text = numValue
                    //на этом моменте мы больше не сможем вводить цифры, для этого надо ввести переменную isFinishedTypingNumber, которую будем "сбрасывать" чтобы могли продолжать печатать сколько хотим. причем она сбрасывается когда мы нажали на кнопку и после этого мы можем делать код из блока else. хитро!
                    isFinishedTypingNumber = false
                }
            } else {
                if numValue == "←" {
                    
                    if outputField.text!.count > 1 {
                        outputField.text?.removeLast()
                    } else {
                        displayValue = Double(0)
                        isFinishedTypingNumber = true
                    }
                    
                } else {
                    
                    //дальше фиксим проблему что мы можем ставить больше одной .
                    if numValue == "." {
                        let isInt = !outputField.text!.contains(".")
                        // floor - округляем цифру до целого числа
                        if !isInt {
                            //если не явялется целым числом, то тогда выходим из этой цепи логики, просто пишем return. и выходим не просто из текущего if, а вообще из els'a всей функции
                            return
                        }
                    }
                    //и  собственно строка добавления цифры в циферблат
                    outputField.text?.append(numValue)
                }
            }
        }
    }
}

// добавили расширение для того чтобы 2.3 x 3 было 6.9, а не 6.8999999(9)
extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        //    numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = 7  // default is 3 decimals
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
