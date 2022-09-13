//
//  MyButton.swift
//  NOTINO
//
//  Created by Jozef Gmuca on 05/09/2022.
//

import Foundation
import UIKit
class MyButton: UIButton {
    public override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
    }
}
