//: Playground - noun: a place where people can play

import UIKit

let x = 80000

let pp = x.description

var price : Double
price = 900


var formatter = NSNumberFormatter()
formatter.numberStyle = .CurrencyStyle
//formatter.maximumFractionDigits = 0
let profitLoss = formatter.stringFromNumber(price)



let strPrice = formatter.numberFromString(profitLoss!)
print(strPrice)

//let strPrice = formatter.numberFromString("$900,00")

let maxNumber = Array(1...10)
    .reduce(0) { (total, number) in max(total, number) }
println(maxNumber)


var xxx : Double

xxx = 1000.123
round(xxx)



