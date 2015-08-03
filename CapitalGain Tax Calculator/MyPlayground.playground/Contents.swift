//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


// var _taxBracketList: [TaxBracket] = [TaxBracket]()

var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}

var evenSum = 0
for i in evens {
    evenSum += i
}

println(evenSum)

evenSum = Array(1...10)
    .filter { (number) in number % 2 == 0 }
    .reduce(0) { (total, number) in total + number }

println(evenSum)



enum ENumTerm:String
{
    case LongTerm = "LongTerm"
    case ShortTerm = "ShortTerm"
    case Section1256 = "Section1256"
}

class LotTerm {
    private var _year: Int32
    private var _termRealizedGainLoss : Double
    private var _term : ENumTerm
    
    init()
    {
        self._year = 0
        self._termRealizedGainLoss = 0
        self._term = ENumTerm.LongTerm
    }
    
    var Year: Int32 {
        get {
            return _year
        }
        set {
            _year = newValue
        }
    }
    
    var TermRealizedGainLoss: Double {
        get {
            return _termRealizedGainLoss
        }
        set {
            _termRealizedGainLoss = newValue
        }
    }
    
    var Term: ENumTerm {
        get {
            return _term
        }
        set {
            _term = newValue
        }
    }
    
    
}



    var arrayLotTerm : [LotTerm] = [LotTerm]()
//    let arrayLotTerm = [LotTerm]()
    let lotTerm1 = LotTerm()

    lotTerm1.Term  = ENumTerm.LongTerm
    lotTerm1.Year = 2015
    lotTerm1.TermRealizedGainLoss = 30000
    
    arrayLotTerm.append(lotTerm1)

let lotTerm2 = LotTerm()

lotTerm2.Term  = ENumTerm.LongTerm
lotTerm2.Year = 2015
lotTerm2.TermRealizedGainLoss = 10000

arrayLotTerm.append(lotTerm2)


    //arrayLotTerm.addObject(lotTerm)
    
//    arrayLotTerm(lotTerm)
    let GL: [Double] = arrayLotTerm.map { return $0.TermRealizedGainLoss }
    let sumGL = GL.reduce(0) { return $0 + $1 }
    
    println(sumGL)
//    var sumGL = arrayLotTerm.reduce(0) { return $0 + $1 }
    


struct Person {
    let name: String
    let age: Int
}

let people = [
    Person(name: "Katie",  age: 23),
    Person(name: "Bob",    age: 21),
    Person(name: "Rachel", age: 33),
    Person(name: "John",   age: 27),
    Person(name: "Megan",  age: 15)
]

let ages: [Int] = people.map { return $0.age }
let agesTotal   = ages.reduce(0) { return $0 + $1 }

println(agesTotal)
