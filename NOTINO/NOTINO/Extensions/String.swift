//
//  String.swift
//  NOTINO
//
//  Created by Jozef Gmuca on 04/09/2022.
//

import Foundation
import UIKit

extension String {
    func computedHeight( width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
