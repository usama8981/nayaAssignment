//
//  UILabel+Extension.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import UIKit

extension UILabel {
    static func imageWithText(image: UIImage, text:String) -> NSAttributedString {
        let textAttachment = NSTextAttachment(image: image)
        let attachmentString = NSAttributedString(attachment: textAttachment)
        
        let attributedString = NSMutableAttributedString(attributedString: attachmentString)
        attributedString.append(NSAttributedString(string: " " + text))
        return attributedString
    }
}
