//
//  View+Ext.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit
import SkeletonView

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    func showShimmeringView() {
        showAnimatedSkeleton(transition: .crossDissolve(1))
    }

    func stopShimmeringView() {
        self.stopSkeletonAnimation()
        self.hideSkeleton()
    }
}
