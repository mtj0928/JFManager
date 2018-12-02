//
//  UIViewController+extension.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import UIKit

extension UIViewController {

    class func createFromStoryboard() -> Self {
        let name = String(describing: type(of: self)).components(separatedBy: ".").first!
        return instantiateFromStoryboard(storyboardName: name)
    }

    private class func instantiateFromStoryboard<T>(storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateInitialViewController() as! T
    }
}
