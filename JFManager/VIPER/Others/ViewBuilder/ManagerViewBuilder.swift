//
//  ManagerViewBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/06.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class ManagerViewBuilder {

    static func buildeDefault(of genre: Genre) -> UIViewController {
        let viewController = UIViewController.createFromStoryboard()
        return viewController
    }
}

