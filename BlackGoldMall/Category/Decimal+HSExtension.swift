//
//  Decimal+HSExtension.swift
//  Wenyishou
//
//  Created by 永芯 on 2020/6/22.
//  Copyright © 2020 永芯. All rights reserved.
//

import Foundation

/***********    DecimalExtension        *******/
extension String {
    enum RoundingType : UInt {

        case plain   //Round up on a tie

        case down    //Always down == truncate

        case giveUp  //Always up

        case bankers //on a tie round so last digit is even
    }

    // MARK: - + string addition
    // - Parameter numberString: string
    // - Returns: result string
    func add(numberString:String) -> String {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: numberString)
        let summation = number1.adding(number2)
        return summation.stringValue
    }

    // MARK: -  - string subtraction
    // - Parameter numberString: string
    // - Returns: result string
    func reduction(numberString:String) -> String {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: numberString)
        let summation = number1.subtracting(number2)
        return summation.stringValue
    }

    // MARK: - * string multiplication
    // - Parameter numberString: string
    // - Returns: result string
    func take(numberString:String) -> String {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: numberString)
        let summation = number1.multiplying(by: number2)
        return summation.stringValue
    }

    // MARK: - / string division
    // - Parameter numberString: string
    // - Returns: result string
    func division(numberString:String) -> String {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: numberString)
        let summation = number1.dividing(by:number2)
        return summation.stringValue
    }

    // MARK: - keep a few decimal places and choose the type
    // - Parameter num: keep a few decimal places  type : choose the type
    // - Returns: string
    func numType(num : Int , type : RoundingType) -> String {
        /*
         enum NSRoundingMode : UInt {

         case RoundPlain     // Round up on a tie
         case RoundDown      // Always down == truncate
         case RoundUp        // Always up
         case RoundBankers   // on a tie round so last digit is even
         }
         */

        // 90.7049 + 0.22
        var rounding = NSDecimalNumber.RoundingMode.down
        switch type {
        case RoundingType.plain:
            rounding = NSDecimalNumber.RoundingMode.plain
        case RoundingType.down:
            rounding = NSDecimalNumber.RoundingMode.down
        case RoundingType.giveUp:
            rounding = NSDecimalNumber.RoundingMode.up
        case RoundingType.bankers:
            rounding = NSDecimalNumber.RoundingMode.bankers
        }
        let roundUp = NSDecimalNumberHandler(roundingMode: rounding, scale:Int16(num), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)

        let discount = NSDecimalNumber(string: self)
        let subtotal = NSDecimalNumber(string: "0")

        let total = subtotal.adding(discount, withBehavior: roundUp).stringValue

        var mutstr = String()

        if total.contains(".") {
            let float = total.components(separatedBy: ".").last!
            if float.count == Int(num) {
                mutstr .append(total)
                return mutstr
            } else {
                mutstr.append(total)
                let all = num - float.count
                for _ in 1...all {
                    mutstr += "0"
                }
                return mutstr
            }
        } else {
            mutstr.append(total)
            if num == 0 {
            } else {
                for _ in 1...num {
                    mutstr += "0"
                }
            }
            return mutstr
        }
    }
}
