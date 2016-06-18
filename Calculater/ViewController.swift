//
//  ViewController.swift
//  Calculater
//
//  Created by 酒井恭平 on 2016/06/18.
//  Copyright © 2016年 酒井恭平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let screenWidth = Double(UIScreen.mainScreen().bounds.size.width)
    private let screenHight = Double(UIScreen.mainScreen().bounds.size.height)
    var resultArea = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        defineResultArea()
        showResultLabel()
        showNumberButton()
    }
    
    private func defineResultArea() {
        switch screenHight {
        case 480:
             resultArea = 200.0
        case 568:
            resultArea = 250.0
        case 667:
            resultArea = 300.0
        case 736:
            resultArea = 350.0
        default:
            resultArea = 0.0
        }
        print("横\(screenWidth),縦\(screenHight)")
    }
    
    private func showNumberButton() {
        let buttonMargin = 10.0
        
        //ボタンの作成
        let xButtonCount = 4
        let yButtonCount = 4
        
        let buttonLabels = [
            "7","8","9","×",
            "4","5","6","-",
            "1","2","3","+",
            "0","C","÷","=",
        ]
        
        for y in (0..<yButtonCount){
            print("y: \(y)")
            for x in (0..<xButtonCount) {
                print("x: \(x)")
                
                let button = UIButton()
                
                let buttonWidth = (screenWidth - (buttonMargin * (Double(xButtonCount)+1))) / Double(xButtonCount)
                let buttonHight = (screenHight - resultArea - ((buttonMargin * Double(yButtonCount)+1))) / Double(yButtonCount)
                
                let buttonPositionX = (screenWidth - buttonMargin) / Double(xButtonCount) * Double(x) + buttonMargin
                let buttonPositionY = (screenHight - resultArea - buttonMargin) / Double(yButtonCount) * Double(y) + buttonMargin + resultArea
                
                button.backgroundColor = UIColor.greenColor()
                button.frame = CGRect(x: buttonPositionX, y: buttonPositionY, width: buttonWidth, height: buttonHight)
                
                let buttonNumber = y * xButtonCount + x
                button.setTitle(buttonLabels[buttonNumber],forState: UIControlState.Normal)
                print(buttonNumber)
                
                self.view.addSubview(button)
                
            }
        }
    }
    
    private func showResultLabel() {
        //結果表示ラベルの作成
        let resultLabel = UILabel()
        resultLabel.frame = CGRect(x: 10, y: 30, width: screenWidth - 20, height: resultArea - 30)
        
        resultLabel.backgroundColor = UIColor.grayColor()
        resultLabel.font = UIFont(name: "Arial", size: 50)
        resultLabel.textAlignment = NSTextAlignment.Right
        resultLabel.numberOfLines = 4
        resultLabel.text = "0"
        
        self.view.addSubview(resultLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

