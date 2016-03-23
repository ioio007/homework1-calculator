//
//  ViewController.swift
//  Calculator
//
//  Created by Jenny Huang on 2016/3/21.
//  Copyright © 2016年 Jenny Huang. All rights reserved.
//

import UIKit
import CalculatorCore


class ViewController: UIViewController {
    
    var core: Core<Float>!
    func resetCore() {
        self.core = Core()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetCore()
    }

    @IBOutlet weak var displayLabel: DisplayLabel!
    
    @IBAction func numericButtonClicked(sender: UIButton) {
        if sender.tag >= 1000 && sender.tag < 1010 {
            self.displayLabel.append(sender.tag - 1000)
        } else if sender.tag == 1010 {
            self.displayLabel.append(0)
            self.displayLabel.append(0)
        } else if sender.tag == 0 {
            self.displayLabel.append(".")
        }

    }
    
    @IBAction func changeSignButtonClicked(sender: UIButton) {
        self.displayLabel.changeSign()
    }
    
    @IBAction func operatorButtonClicked(sender: UIButton) {
        try! self.core.addStep(self.displayLabel.floatValue)
        
        switch (sender.titleForState(.Normal)!) {
        case "+":
            try! self.core.addStep(+)
        case "-":
            try! self.core.addStep(-)
        case "÷":
            try! self.core.addStep(/)
        case "×":
            try! self.core.addStep(*)
        default:
            break
        }
        
        self.displayLabel.clear()
    }
    
    @IBAction func calculateButtonClicked(sender: UIButton) {
        try! self.core.addStep(self.displayLabel.floatValue)
        self.displayLabel.floatValue = try! self.core.calculate()
        self.resetCore()
    }
    
    @IBAction func reserButtonClicked(sender: UIButton) {
        self.resetCore()
        self.displayLabel.clear()
    }
    
    @IBAction func percentButtonClicked(sender: UIButton) {
        try! self.core.addStep(self.displayLabel.floatValue)
        try! self.core.addStep(/)
        try! self.core.addStep(100.0)
        self.displayLabel.floatValue = try! self.core.calculate()
        self.resetCore()
    }
}

