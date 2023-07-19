//
//  View+Ext.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit
import SkeletonView

extension UIView {
    func showShimmeringView() {
        showAnimatedSkeleton(transition: .crossDissolve(1))
    }

    func stopShimmeringView() {
        self.stopSkeletonAnimation()
        self.hideSkeleton()
    }
}
