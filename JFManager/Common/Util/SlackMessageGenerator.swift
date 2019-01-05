//
//  SlackMessageGenerator.swift
//  JFManager
//
//  Created by 松本淳之介 on 2019/01/05.
//  Copyright © 2019 Kusumoto Lab. All rights reserved.
//

import Foundation

class SlackMessageGenerator {

    static func generate(users: [User], genre: Genre, managerName: String) -> String {
        let now = Date()
        let date = Date.init(timeInterval: -4 * 604800, since: now)
        let components = Calendar.current.dateComponents([.month], from: date)

        let results = users
            .filter({ user in
                let history = user.history
                return !history.filter({ $0.shouldBeLiquidate(genre: genre) }).isEmpty
            })
            .map ({ user -> (name: String, price: Int) in
                let price = user.history
                    .filter({ $0.shouldBeLiquidate(genre: genre)})
                    .reduce(0, { (result, purchase) -> Int in
                        return result + purchase.product.price
                    })
                return (name: user.name, price: price)
            })
        var text = """
        楠本研究室の皆様

        \(genre.japanese)大臣の\(managerName)です．
        \(String(describing: components.month!))月分の\(getPriceName(genre: genre))代金は以下のようになっております．\n\n
        """
        text = results.reduce(text) { (text, result) -> String in
            return text + "\(result.name)\t\t￥\(result.price)\n"
        }
        text += """

        つきましては\(managerName)までお支払いをお願いいたします．
        何かご不明な点等ございましたら\(managerName)までご連絡ください．
        """
        return text
    }

    private static func getPriceName(genre: Genre) -> String {
        switch genre {
        case .drink:
            return "ジュース"
        case .food:
            return "食品"
        }
    }
}
