//
//  ViewController.swift
//  Calculater
//
//  Created by 酒井恭平 on 2016/06/18.
//  Copyright © 2016年 酒井恭平. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    private let screenWidth = Double(UIScreen.mainScreen().bounds.size.width)
    private let screenHight = Double(UIScreen.mainScreen().bounds.size.height)
    var resultArea = 0.0
    let resultLabel = UILabel()
    
    var number1:NSDecimalNumber = 0.0
    var number2:NSDecimalNumber = 0.0
    var result:NSDecimalNumber = 0.0
    var operatorId:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        defineResultArea()
        showResultLabel()
        showNumberButton()
        
    }
    
    //結果表示画面の決定
    private func defineResultArea() {
        
        //self.view.backgroundColor = UIColor.yellowColor()
        
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
    
    
    //ボタンの生成
    private func showNumberButton() {
        
        let buttonMargin = 10.0
        let xButtonCount = 4
        let yButtonCount = 4
        
        let buttonLabels = [
            "7","8","9","×",
            "4","5","6","-",
            "1","2","3","+",
            "0","C","÷","=",
        ]
        
        for y in (0..<yButtonCount){
            //print("y: \(y)")
            for x in (0..<xButtonCount) {
                //print("x: \(x)")
                
                let button = UIButton()
                
                let buttonWidth = (screenWidth - (buttonMargin * (Double(xButtonCount)+1))) / Double(xButtonCount)
                let buttonHight = (screenHight - resultArea - ((buttonMargin * Double(yButtonCount)+1))) / Double(yButtonCount)
                
                let buttonPositionX = (screenWidth - buttonMargin) / Double(xButtonCount) * Double(x) + buttonMargin
                let buttonPositionY = (screenHight - resultArea - buttonMargin) / Double(yButtonCount) * Double(y) + buttonMargin + resultArea
                
                //button.backgroundColor = UIColor.greenColor()
                let gradient = CAGradientLayer()
                gradient.frame = button.bounds
                let arrayColors = [
                    colorWithRGBHex(0xFFFFFF, alpha: 1.0).CGColor as AnyObject,
                    colorWithRGBHex(0xCCCCCC, alpha: 1.0).CGColor as AnyObject]
                gradient.colors = arrayColors
                button.layer.insertSublayer(gradient, atIndex: 0)
                
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 5.0
                
                button.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
                button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
                
                button.frame = CGRect(x: buttonPositionX, y: buttonPositionY, width: buttonWidth, height: buttonHight)
                
                let buttonNumber = y * xButtonCount + x
                button.setTitle(buttonLabels[buttonNumber],forState: UIControlState.Normal)
                //print(buttonNumber)
                
                self.view.addSubview(button)
                
                button.addTarget(self, action: #selector(ViewController.buttonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                
            }
        }
    }
    
    
    //結果表示ラベルの生成
    private func showResultLabel() {
        
        resultLabel.frame = CGRect(x: 10, y: 30, width: screenWidth - 20, height: resultArea - 30)
        //resultLabel.backgroundColor = UIColor.grayColor()
        resultLabel.backgroundColor = self.colorWithRGBHex(0xF5F5DC, alpha: 1.0)
        //resultLabel.font = UIFont(name: "Arial", size: 50)
        resultLabel.font = UIFont(name: "Let's go Digital Regular", size: 50)
        resultLabel.textAlignment = NSTextAlignment.Right
        resultLabel.numberOfLines = 4
        resultLabel.text = "0"
        
        self.view.addSubview(resultLabel)
    }
    
    
    //ボタンタップのアクション設定
    @IBAction func buttonTapped(sender: UIButton){
        let tappedButtonTitle: String = sender.currentTitle!
        print("\(tappedButtonTitle)ボタンが押されました！")
        
        switch tappedButtonTitle{
        case "0","1","2","3","4","5","6","7","8","9":
            numberButtonTapped(tappedButtonTitle)
        case "×","-", "+","÷":
            operatorButtonTapped(tappedButtonTitle)
        case "=":
            equalButtonTapped(tappedButtonTitle)
        default:
            clearButtonTapped(tappedButtonTitle)
        }
    }
    
    //数字ボタンタップ
    private func numberButtonTapped(tappedButtonTitle:String){
        
        print("numberTapped:\(tappedButtonTitle)")
        
        let tappedButtonNum:NSDecimalNumber = NSDecimalNumber(string: tappedButtonTitle)
        
        number1 = number1.decimalNumberByMultiplyingBy(NSDecimalNumber(string: "10")).decimalNumberByAdding(tappedButtonNum)
        
        resultLabel.text = number1.stringValue
        
    }
    
    //演算子ボタンタップ
    private func operatorButtonTapped(tappedButtonTitle:String){
        
        print("operatorTapped:\(tappedButtonTitle)")
        
        operatorId = tappedButtonTitle
        
        number2 = number1
        
        number1 = NSDecimalNumber(string: "0")
        
    }
    
    //イコールボタンタップ
    private func equalButtonTapped(tappedButtonTitle:String){
        
        print("equalTapped:\(tappedButtonTitle)")
        
        switch operatorId {
        case "+":
            result = number2.decimalNumberByAdding(number1)
        case "-":
            result = number2.decimalNumberBySubtracting(number1)
        case "×":
            result = number2.decimalNumberByMultiplyingBy(number1)
        case "÷":
            if(number1.isEqualToNumber(0)){
                number1 = 0
                resultLabel.text = "∞"
            }else{
                result = number2.decimalNumberByDividingBy(number1)
            }
        default:
            print("others")
        }
        
        number1 = result
        resultLabel.text = String("\(result)")
        
    }
    
    //クリアボタンタップ
    private func clearButtonTapped(tappedButtonTitle:String){
        
        print("clearTapped:\(tappedButtonTitle)")
        
        number1 = NSDecimalNumber(string: "0")
        number2 = NSDecimalNumber(string: "0")
        result = NSDecimalNumber(string: "0")
        operatorId = ""
        resultLabel.text = "0"
        
    }
    
    //HEX値で設定メソッド
    private func colorWithRGBHex(hex: Int, alpha: Float = 1.0) -> UIColor {
        
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        return UIColor(red: CGFloat(r / 255.0),
                       green: CGFloat(g / 255.0),
                       blue: CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

