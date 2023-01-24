//  ViewController.swift
//  Calculator
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var clearButton: UIButton!
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {

        // решили сделать из displayValue computedProperty, чтобы он сам себя считал, и делам это через геттер  (брал гдето число сам) и сеттер (устанавлиаем displayLabel.text - как и нахуя пока хз)
        
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("cannot conver display label text to a Double")
            }
            return number
        }
        set {
//            displayLabel.text = newValue.withCommas() // - это если используем расширение с самого низа
            displayLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
//        это я сам добавил, хз почему этого не было!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        
        // добавили строку ниже чтобы показать что мы закончили писать цифорки, что редактура кончилась, все! финита ля комедия!
        isFinishedTypingNumber = true
        
//        изначально у нас был код:
//        let number = Double(displayLabel.text!)!
//        потому что когда мы нажимаем на какую либо кнопку операций, которая входит в calcButtonPressed, нам текущую цифру на экране нужно запомнить
        
//        потом мы это переделали на вот:
//        guard let number = Double(displayLabel.text!) else {
//            fatalError("Cannot convert display label")
//        }
//         это всё мы перенесли на уровень выше, в  displayValue
        // читаем так: если number = nil, то тогда выдать ошибку, если ок, то нихуя не будет
//        дальше, ВМЕСТЕ с этим надо реализовать логику подсчета (до того как мы перенесли её в CalculatorLogic)
//
//        if let calcMethod = sender.currentTitle {
//            if calcMethod == "+/-" {
//                displayLabel.text = String(number * -1)
//            } else if calcMethod == "AC" {
//                displayLabel.text = "0"
//            } else if calcMethod == "%" {
//                displayLabel.text = String(number * 0.01)
//            }
        
        calculator.setNumber(displayValue)
         
    if let calcMethod = sender.currentTitle {
            if calcMethod == "C" {
                clearButton.setTitle("AC", for: .normal)
            }
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        
        }
    }

    // мой код на backspace
//    @IBAction func backspacePressed(_ sender: UIButton) {
//        if var number = displayLabel.text {
//            if isFinishedTypingNumber == true {
//                number.removeLast()
//                displayValue = Double(number)!
//                isFinishedTypingNumber = false
//            } else {
//                number.removeLast()
//                displayValue = Double(number)!
//            }
//        }
//    }
//      вот это кажется самым красивым решением проблемы с <-, но изза Double не оч реализуемо
//    if var number = displayLabel.text {
//        if isFinishedTypingNumber == true {
//            number = "\(number.removeLast())"
//            isFinishedTypingNumber = false
//        } else {
//            number = "\(number.removeLast())"
//        }
//    }

    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        
        //замена AC на C. всрато, но работает. ругается что "Comparing non-optional value of type 'Double' to 'nil' always returns true"
        if displayValue != nil {
            clearButton.setTitle("C", for: .normal)
        }
        
        
        // вообще, мы можем ограничиться displayLabel.text = sender.currentTitle, но currentTitle у нас String? то есть нужно блять как то его проверить, поэтому через if let проверяем что currenTitle не пустой
        
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber == true {

                //бэкспэйс засунул сюда
                if numValue == "⬅" {
                    // блять есть два варианта, первый:
                    // с этим вариантом все хорошо работает, но он удаляет цифры до их полного отсутствия, то есть даже 0 нет
                    if displayLabel.text!.count >= 1 {
                        displayLabel.text?.removeLast()
                    } else {
                        displayLabel.text = String(0)
                    }
//                    второй вариант - удаляет до последнего символа. если 1 символ на экране, то превращает его в 0, но есть баг. последний символ 0 и если начинаешь печатать числа на экране, то он пишет 0999, то есть 0 не исчезает.
//                                        if displayLabel.text!.count == 1 {
//                                            displayLabel.text = String(0)
//                                        } else {
//                                            displayLabel.text?.removeLast()
//                                        }
                } else {
                //идея, поставить тут условие что если numvalue == "⬅", то удаляем последнюю цифру из дисплея.
                //  if numValue == "⬅" {
                //  displayLabel.text?.removeLast()
                //  }
                
                displayLabel.text = numValue
                //на этом моменте мы больше не сможем вводить цифры, для этого надо ввести переменную isFinishedTypingNumber, которую будем "сбрасывать" чтобы могли продолжать печатать сколько хотим. причем она сбрасывается когда мы нажали на кнопку и после этого мы можем делать код из блока else. хитро!
                isFinishedTypingNumber = false
                }
            } else {
                if numValue == "⬅" {

                    if displayLabel.text!.count >= 1 {
                        displayLabel.text?.removeLast()
                    } else {
                        displayLabel.text = String(0)
                    }
                    
                } else {
                //дальше фиксим проблему что мы можем ставить больше одной .
                if numValue == "." {
            //раньше было еще вот это, но нихуя не понятно нахуя
            //guard let currentDisplayValue = Double(displayLabel.text!) else {
            //fatalError("Cannot convert displayLabel text to a Double")
            //}
                    
                    let isInt = floor(displayValue) == displayValue
                    // floor - округляем цифру до целого числа
                    if !isInt {
                        //если не явялется целым числом, то тогда выходим из этой цепи логики, просто пишем return. и выходим не просто из текущего if, а вообще из els'a всей функции
                        return
                    }
                }
                
                //и  собственно строка добавления цифры в циферблат
                displayLabel.text?.append(numValue)
                }
            }
        }
    }
}

// добавили расширение для того чтобы 2.3 x 3 было 6.9, а не 6.8999999(9)
//extension Double {
//  func withCommas() -> String {
//    let numberFormatter = NumberFormatter()
//    numberFormatter.numberStyle = NumberFormatter.Style.decimal
//    numberFormatter.maximumFractionDigits = 3  // default is 3 decimals
//    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
//  }
//}