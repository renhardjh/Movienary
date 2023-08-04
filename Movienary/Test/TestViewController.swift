//
//  TestViewController.swift
//  Movienary
//
//  Created by RenhardJH on 04/08/23.
//

import UIKit

class TestViewController: BaseViewController {

    convenience init() {
        self.init(nibName: String(describing: type(of: self)), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
