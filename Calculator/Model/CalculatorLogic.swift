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
            case "±": return n * -1
            case "AC": intermediateCalculation = nil
                //подсмотрел строку выше
                return 0
            case "%": return n * 0.01
            case "C": return 0
            case "=": let result = performTwoNumCalculation(n2: n)
                // чистим предыдущие вычисления, подсмотрел это https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/11860696#questions/9484524
                intermediateCalculation = nil
                return result
                
            // если нажимаем +, -, ×, ÷, то происходит вот
            default:
                var result = n
                // if there has been any previous calculation pending, peform it and return result
                // result will be an input for next intermediateCalculation
                if let previousCalcResult = performTwoNumCalculation(n2: n) {
                                    result = previousCalcResult
                }
                intermediateCalculation = (n1: result, calcMethod: symbol)
                return result
            }
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
