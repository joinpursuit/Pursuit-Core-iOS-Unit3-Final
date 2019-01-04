//
//  UIAlertController+Extensions.swift
//  Elements
//
//  Created by J on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

extension UIAlertController {
  static func errorController(error:AppError) -> UIAlertController{
    let alert = UIAlertController(title: "Error",
                                  message: error.userErrorMessage(), preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    return alert
  }
}
