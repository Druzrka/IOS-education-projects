//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Захар on 25.08.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add  = "+"
        case Empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLabel.text = "0"
        runningNumber = "0"
    }
    
    
    @IBAction func divideButtonPressed(_ sender: UIButton) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func multiplyButtonPressed(_ sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func subtractButtonPressed(_ sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        processOperation(operation: .Add)
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        if runningNumber != "0" {
            runningNumber += "\(sender.tag)"
            outputLabel.text = runningNumber
        }
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
            
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if !runningNumber.isEmpty {
                rightValStr = runningNumber
                runningNumber = ""
                print("right value \(rightValStr, leftValStr)")
                
                switch currentOperation {
                case Operation.Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    break
                    
                case Operation.Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    break
                    
                case Operation.Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    break
                    
                case Operation.Subtract:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    break
                    
                default:
                    result = ""
                    break
                }
                
                leftValStr = result
                outputLabel.text = result
            }
            currentOperation = operation
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }
}

