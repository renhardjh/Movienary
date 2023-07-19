//
//  Array+Ext.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

extension Array {
    func item(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
}
