//
//  SlackSendButtonCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2019/01/04.
//  Copyright © 2019 Kusumoto Lab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SlackSendButtonCell: UITableViewCell {
    
    @IBOutlet private(set) weak var sendButton: UIButton!
    private(set) var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }
}
