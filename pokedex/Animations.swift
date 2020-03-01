//
//  Animations.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-22.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import Foundation
import UIKit

// Usage: insert view.fadeTransition right before changing content

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = .fade
        animation.duration = duration
        self.layer.add(animation, forKey: CATransitionSubtype.fromLeft.rawValue)
    }
}

extension UIColor{
    func adjust(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat) -> UIColor{
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r+red, green: g+green, blue: b+blue, alpha: a+alpha)
    }
}
