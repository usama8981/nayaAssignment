//
//  UIString+Extension.swift
//  NayaAssignment
//
//  Created by Usama Ali on 03/04/2022.
//


import UIKit


extension String{
    
    func paymentFormatted() -> String {
        var selfString = self
        selfString = selfString.replacingOccurrences(of: ",", with: "")
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: selfString)
        let paymentFloatValue = number!.floatValue
          numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber =  numberFormatter.string(from: NSNumber(value:paymentFloatValue))
        // Should get currency from API
        if self == "0" {
            return "AED 0.00"
        }
        if (formattedNumber?.contains("."))! {
            return "\(formattedNumber ?? "") AED"

        } else {
            return "\(formattedNumber ?? "") AED"

        }
    }
    
    func createAttributedString(stringtToStrike: String) -> NSMutableAttributedString {
            let attributedString = NSMutableAttributedString(string: self)
            let range = attributedString.mutableString.range(of: stringtToStrike)
            attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single], range: range)
            return attributedString
        }
}
