//  CalculatorLogic.swift
//  Calculator
//  Created by Renat Nazyrov on 17.01.2023.
//  Copyright © 2023 London App Brewery. All rights reserved.

import Foundation

struct CalculatorLogic {
    
    //1. цифра, которую принимаем из viewController, пока просто называем её и задаём тип Double
    // почему оно optional? потому что когда мы запускаем приложение мы не уверены что у него есть цифра, поэтому и создаем его через ? 
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    //2. дальше, устанавливаем функцию "установить цифру". по сути, это инициализатор для нашего number
    mutating func setNumber(_ number: Double) {
        self.number = number
        // self.number = проперти внутри текущего класса/структуры, поэтому это number c 13 строки
    }
    
    mutating func calculate(symbol: String) -> Double? {
        // пишем if let n потому что number у нас ?
        if let n = number {

            switch symbol {
            case "+/-": return n * -1
            case "AC": return 0 
            case "%": return n * 0.01
            case "C": return 0
            case "=": return performTwoNumCalculation(n2: n)
                // если нажимаем +, -, ×, ÷, то происходит вот
            default: intermediateCalculation = (n1: n, calcMethod: symbol)
            }
//            если у нас уже есть n1 и n2         if let n1 = intermediateCalculation?.n1,
//            let n2 = n
//            если "+, -, ×, ÷ ": return performTwoNumCalculation(n2: n)
            }
        return nil
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1,
           let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+": return n1 + n2
            case "-": return n1 - n2
            case "×": return n1 * n2
            case "÷": return n1 / n2
            default: fatalError("the operation passed in does not match any of the cases")
            }
        }
        return nil
    }
}


