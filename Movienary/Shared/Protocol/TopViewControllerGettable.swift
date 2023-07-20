//
//  TopViewControllerGettable.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

protocol TopViewControllerGettable  {
    var topViewController: UIViewController? { get }
    var topNavController: UINavigationController? { get }
    var topTabController: UITabBarController? { get }
}

extension TopViewControllerGettable {
    var topViewController: UIViewController? {
        return UIApplication.shared.topViewController
    }

    var topNavController: UINavigationController? {
        return UIApplication.shared.topViewController as? UINavigationController
    }

    var topTabController: UITabBarController? {
        return UIApplication.shared.topViewController as? UITabBarController
    }
}
