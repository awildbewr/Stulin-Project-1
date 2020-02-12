//
//  statsStruct.swift
//  project1
//
//  Created by White, Nicholas R. on 16/11/19.
//  Copyright © 2019 White, Nicholas R. All rights reserved.
//
import Foundation

struct Stats {
  let values: [Double]
  init (values: [Double]) {
    self.values = values
  }

  func sum() -> Double {
    var total = 0.0
    for v in values {
      total += v
    }
    return total
  }

  func mean() -> Double {
    if values.count == 0 {
      return 0.0
    }
    return sum() / Double(values.count)
  }

  func median() -> Double {
    if values.count == 0 {
      return 0.0
    }
    let sortvalues = values.sorted()
    if sortvalues.count % 2 == 0 {
        return Double((sortvalues[(sortvalues.count / 2)] + sortvalues[(sortvalues.count / 2) - 1])) / 2
    } else {
        return Double(sortvalues[(sortvalues.count - 1) / 2])
    }
  }

  func medianINTERNAL(_ values: [Double]) -> Double {
    let sortvalues = values.sorted()
    if sortvalues.count % 2 == 0 {
        return Double((sortvalues[(sortvalues.count / 2)] + sortvalues[(sortvalues.count / 2) - 1])) / 2
    } else {
        return Double(sortvalues[(sortvalues.count - 1) / 2])
    }
    
    
  }

  func standardDeviation() -> Double {
    if values.count == 0 {
      return 0.0
    }
    var ansFin = 0.0
    var sumOfAll = 0.0
    let avg = mean()
    for v in values {
      sumOfAll += ((v - avg) * (v - avg))
    }
  ansFin = sqrt(sumOfAll / Double((values.count - 1)))
  return ansFin
  }

  func isPrimeNumber(_ number: Int) -> Bool {
    if number == 1 {
      return false
    }
    var counter = 2
    while counter < number {
      if number % counter == 0 {
        return false
      }
      counter += 1
    }
    return true
  }

  func primes() -> [Int] {
    var primesList = Set<Int>()
    for v in values {      
      let val = isPrimeNumber(Int(v))
      if val == true {
        primesList.insert(Int(v))
      }
      
    }
    return Array(primesList).sorted()
  }

  func five() -> (smallest: Double, q1: Double, median: Double, q3: Double, largest: Double) {
    if values.count == 0 {
      return (smallest: 0.0, q1: 0.0, median: median(), q3: 0.0, largest: 0.0)
    }
    let newvalues = values.sorted()
    var q1 = 0.0
    var q3 = 0.0
    if values.count % 2 == 0 {
      let q1N = Array(values[0...(values.count / 2) - 1])
      q1 = medianINTERNAL(q1N)

      let q3N = Array(values[(values.count - (values.count / 2))...(values.count - 1)])
      q3 = medianINTERNAL(q3N) 
    }
    if values.count % 2 == 1 {
      let q1N = Array(values[0...(values.count - 1) / 2 - 1])
      q1 = medianINTERNAL(q1N)

      let q3N = Array(values[(values.count - ((values.count - 1) / 2))...(values.count - 1)])
      q3 = medianINTERNAL(q3N) 
    }
    return (smallest: newvalues[0], q1: q1, median: median(), q3: q3, largest: newvalues[newvalues.count - 1])
  }
}