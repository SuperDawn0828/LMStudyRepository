//: Playground - noun: a place where people can play

import UIKit

extension Array {
    func lmFilter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var filterArray: [Element] = []
        for element in self {
            if isIncluded(element) {
                filterArray.append(element)
            }
        }
        return filterArray
    }
    
    func lmReduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        for element in self {
            result = nextPartialResult(result, element)
        }
        return result
    }
    
    func lmMap<T>(_ transform: (Element) -> T) -> [T] {
        var mapArray: [T] = []
        for element in self {
            let map = transform(element)
            mapArray.append(map)
        }
        return mapArray
    }
}

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let filter = numbers.lmFilter{ $0 % 2 == 0 }
let reduce = numbers.lmReduce(10) { $0 + $1 }
let map = numbers.lmMap{ " number is \($0)" }
print(filter)
print(reduce)
print(map)
