//: Playground - noun: a place where people can play

import UIKit

let x = 80000

let pp = x.description

var price : Double
price = 900


var formatter = NSNumberFormatter()
formatter.numberStyle = .CurrencyStyle
let profitLoss = formatter.stringFromNumber(price)


let strPrice = formatter.numberFromString(profitLoss!)
print(strPrice)

//let strPrice = formatter.numberFromString("$900,00")



