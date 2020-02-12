//
//  statsStructVC.swift
//  project1
//
//  Created by White, Nicholas R. on 16/11/19.
//  Copyright © 2019 White, Nicholas R. All rights reserved.
//
import Foundation
import Glibc

struct StatsVC {
  var data = [String : Stats] ()
  init () {
    self.data = ["default" : Stats(values: [1.0, 2.0, 3.0, 4.0, 5.0])]
    self.values = []
    self.info = ""
    self.current = "default"
    self.command = ""
  }
  var command:String
  var newname = "name"
  var values:[Double]
  var info:String
  var current:String
  
  mutating func runStats() {
    print("Welcome to Stats!")
    command = getCommand()
    while command != "quit" {
      let commandLine = command.split(separator: " ").map(String.init)
      executeCode(commandLine)
      command = getCommand() //retreive the command the user entered
    }
    print("Would you like to save contents before quitting (y/n)?\n", terminator: "")
    var answer = getCommand()
    while answer != "y" && answer != "n"{
      print("Command Invalid")
      print("Would you like to save contents before quitting (y/n)?\n", terminator: "")
      answer = getCommand()
    }
    if answer == "y" {
      print("Enter the name of the file you'd like to save to.")
      let fin = getCommand()
      writeDataToFile(fin)
    }
    print("done")
  }

  mutating func addStats(_ info: [String]) {
    //print(info)
    var statsInfo:[Double] = []
    var name = ""
    //print("ready on 1")
    if info.count == 2 || info.count == 1 || info.count == 0 {
      //print("crash in 1")
      print("An error took place: \"\(info[0])\" contained no usable data")
      name = "default"
      statsInfo = [1.0, 2.0, 3.0, 4.0, 5.0]
    } else {
      //print("crash in 2")
      if info.count == 2 {
        print("An error took place: \"\(info[1])\" contained no usable data")
      } else {
        //print("crash in 3")
        //print("loading...")
        name = "\(info[1])"
        for i in 2...info.count - 1 {
          if Double(info[i]) != nil {
            statsInfo += [Double(info[i])!]
          }
        }
      }      
    }
    data["\(name)"] = Stats(values: statsInfo.sorted())
    currentPoint(name)
  }

  mutating func currentPoint(_ currentOn: String) {
    if data[currentOn] != nil {
      current = currentOn
    } else {
      print("An error took place: \"\(currentOn)\" could not be found")
    }
    
  }
  
  func readData(_ fileName: String) {
    let filePath = fileName + ".txt"
    do {
      // Read file content
      let contentFromFile = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue)
      print(contentFromFile)
    }
    catch let error as NSError {
      print("An error took place: \(error)")
    }
  }
  mutating func splitImportLines(_ path: String) {
    //print("This feature in beta as of right now. \n\nSome parts do work, however major features are either broken or missing. \nPlease be aware that this program may abruptly terminate the code, so all cached data will now be backed up in \"backup.txt\"\n")
    writeDataToFile("backup")
    var counter = 0
    let filePath = path + ".txt"
    do {
      // Read file content
      let contentFromFile = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue)
      let data = (contentFromFile as String).split(separator: " ").map(String.init)
      //print(data)
      
      while counter != data.count - 1 {
        var info: [String] = []
        for d in data  {
        if d == "\n" {
          break
        } else {
          info += [data[counter]]
        }
        counter += 1
        }
        importDataFromLine(info)
        //counter -= 1
        if counter == data.count || counter == data.count - 2 || counter == data.count - 3 {
          break
        }
        //print("Counter: \(counter), Data Quantity: \(data.count) ")
      }
    }
    catch let error as NSError {
      print("An error took place: \(error)")
    }
  }
  mutating func importDataFromLine(_ info: [String]) {
    //print("attepting line import...\n")
    if info[1] == "DATA:" {
      let nInfo = info[1...info.count - 1]
      addStats(Array(nInfo))
    } else {
      addStats(info)
    }
    //print("import succesfull\n")
  }
    
  func writeDataToFile(_ fileName: String) {
    let filePath = fileName + ".txt"
    let fileContentToWrite = "\(nShowInfo())"
    do {
      // Write contents to file
      try fileContentToWrite.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
    }
    catch let error as NSError {
      print("An error took place: \(error)")
    }
  }
  mutating func executeCode(_ commandLine: [String]) {
    switch commandLine[0] { //all the commands the user can interact with.
        case "add": 
          addStats(commandLine)
        case "current":
          currentPoint(commandLine[commandLine.count - 1])
        case "sum": 
          print("  Sum is " + "\(data[current]!.sum())")
        case "mean": 
          print("  Mean is " + "\(data[current]!.mean())")
        case "median": 
          print("  Median is " + "\(data[current]!.median())")
        case "stdev": 
          print("  Standard Deviation is " + "\(data[current]!.standardDeviation())")
        case "primes":
          print("  Primes are " + "\(data[current]!.primes())")
        case "five": 
          print(data[current]!.five())
        case "write": 
          writeDataToFile(commandLine[commandLine.count - 1])
        case "read": 
          readData(commandLine[commandLine.count - 1])
          splitImportLines(commandLine[commandLine.count - 1])
        case "help": 
          helpCommands()
        case "info": 
          print(showInfo())
        case "Credits":
          break
        case "hello":
          print("Hi! :)")
        case "i", "import":
          splitImportLines(commandLine[commandLine.count - 1])
        default: 
          print("An error took place: unknown command: \(commandLine[0])")
    }
  }
  
  func showInfo() -> String{
    var quote:String = ""
    for d in data {
      quote += "\(currentCheck(d.0, current: current))\(d.0) : \(d.1.values)\n"
    }
    return quote
  }

  func nShowInfo() -> String{
    func valSplit(_ info: [Double]) -> String {
      var result = ""
      for i in info {
        result += "\(i) "
      }
      return result
    }
    var quote:String = ""
    for d in data {
      quote += " DATA: \(d.0) \(valSplit(d.1.values)) \n"
    }
    return quote
  }

  
}