//
//  UIView.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 30.06.2025.
//

import UIKit


extension UIView {
    /// Bu extension, bir UIView’in (örneğin UITableViewCell) hangi view controller’a ait olduğunu bulur.
    /// Böylece hücre içinden .present(...) gibi bir şey yapmak için önce parentViewController bulunur.
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
