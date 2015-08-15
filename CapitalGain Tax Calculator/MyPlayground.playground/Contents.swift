//: Playground - noun: a place where people can play

import UIKit

let x = round(1379.8000000000002)



var set = Set([1, 2, 3, 2, 1])

// Add single elements:
set.insert(4)
set.insert(3)

// Add multiple elements:
set.unionInPlace([ 4, 5, 6 ])

// Remove single element:
set.remove(2)

// Remove multiple elements:
set.subtractInPlace([ 6, 7 ])

println(set) // [5, 3, 1, 4]

