//
//  FindTheOdd.swift
//  Desafio - Find the Odd
//
//  Created by Raul de Medeiros on 13/03/23.
//

import Foundation

struct FindTheOdd {
    static func findOdd(list : String) -> [Int]{
        let numbers = FindTheOdd().parse(list: list)
        var dictionaryNumbers : [Int : Int] = [:]
        for number in numbers {
            if dictionaryNumbers.isEmpty {
                dictionaryNumbers[number] = +1
            } else {
                if (dictionaryNumbers[number] != nil) {
                    dictionaryNumbers[number]! += 1
                } else {
                    dictionaryNumbers[number] = 1
                }
            }
        }
        
        var odds : [Int] = []
        
        for keys in dictionaryNumbers.keys {
            if dictionaryNumbers[keys]! % 2 != 0 {
                odds.append(keys)
            }
        }
        
        return odds
    }
    
    static func createThePhrase(numbers: [Int]) -> String{
        var phrase : String = "Os ímpares são: "
        for num in numbers {
            phrase += "\n\(num) "
        }
        
        return phrase
    }
    
    private func parse(list : String) -> [Int] {
        let separate = list.components(separatedBy: ",")
        
        var listNumbers : [Int] = []
        for numberString in separate {
            let num = Int(numberString)
            listNumbers.append(num ?? 0)
        }
        print(listNumbers)
        return listNumbers
    }
}
