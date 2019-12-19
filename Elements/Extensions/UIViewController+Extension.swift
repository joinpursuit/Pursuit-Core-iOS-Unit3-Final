//
//  UIViewController+Extension.swift
//  Elements
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(_ title: String, _ message: String, completion: ((UIAlertAction) ->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
