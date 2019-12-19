//
//  UIViewController + Alerts.swift
//  Elements
//
//  Created by Matthew Ramos on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}
