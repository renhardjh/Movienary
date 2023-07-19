//
//  UIColor+Ext.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
