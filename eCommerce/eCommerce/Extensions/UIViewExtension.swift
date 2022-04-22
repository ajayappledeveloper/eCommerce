//
//  UIViewExtension.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import UIKit

extension UIView {
    func constraintsToFit(superview: UIView, insets: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right),
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
        ])
    }
}
