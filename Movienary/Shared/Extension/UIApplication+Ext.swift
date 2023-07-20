//
//  UIApplication+Ext.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

extension UIApplication {
    var topViewController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if keyWindow?.rootViewController == nil{
            return keyWindow?.rootViewController
        }

        var pointedViewController = keyWindow?.rootViewController

        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
    }
}
