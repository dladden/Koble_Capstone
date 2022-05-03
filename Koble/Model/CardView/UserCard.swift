//
//  UserCard.swift
//  Koble
//
//  Created by Denys Ladden on 5/1/22.
//

import Foundation
import Shuffle_iOS
import UIKit

class UserCard: SwipeCard{
    
    func configure(model: UserCardModel) {
        content = UserCardContentView(withImage: model.image)
        footer = UserCardFooterView(withTitle: "\(model.name), \(model.age)", subTitle: model.interest)
    }
    
    
}
