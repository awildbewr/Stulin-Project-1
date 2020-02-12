//
//  helper.swift
//  project1
//
//  Created by White, Nicholas R. on 16/11/19.
//  Copyright © 2019 White, Nicholas R. All rights reserved.
//
func getCommand() -> String { //this gets the data that the user inputed
  print("Command...", terminator: "")
  var input = readLine()!
  var commandLine = input.split(separator: " ").map(String.init)
   if input == "Credits"{
     print("\nDon't steal my code! :-D \nThis code is developed by Nicholas White\n")
   }
   while commandLine.count == 0 {
     print("An error took place: no input recognised")
     print("Command...", terminator: "")
     input = readLine()!
     commandLine = input.split(separator: " ").map(String.init)
   }
  return input
}

func currentCheck(_ input: String, current: String) -> String {
  if input == current {
    return "*"
  }
  return " "
}

func stulinTestONE() {
  let s = Stats(values:[5.5, 3.2, 3.6, 4.8, 13, 9.1, 19.5, 3.7])
  print("sum: \(s.sum())")
  print("mean: \(s.mean())")
  print("median: \(s.median())")
  print("standard deviation: \(s.standardDeviation())")
  print("primes: \(s.primes())")
}

func helpCommands() {
  print("")
  print("Stats Commands:")
  print("")
  print("add name d1 d2 d3 ... - add a new stats data set")
  print("       current name - set the current stats data set to name")
  print("       sum - sum of current data set")
  print("       mean - mean of current data set")
  print("       median - median of current data set")
  print("       stdev - standard deviation of current data set")
  print("       primes - prime numbers in current data set")
  print("       five - five-number summary of current data set")
  print("       write fileName - write the stats data base to file fileName")
  print("       read fileName - read the stats data base to file fileName")
  print("       help - this help message")
  print("       info - info report")
  print("       quit - quit stats")
  print("")
  
}

