//
//  UserCardModel.swift
//  Koble
//
//  Created by Denys Ladden on 5/1/22.
//

import Foundation
import UIKit

struct UserCardModel {
    let id: String//id per card so that we can identify each card by UID
    let name: String
    let age: Int
    let interest: String?
    let image: UIImage?
}
