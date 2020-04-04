//
//  SingleUsrModel.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import Foundation

// MARK: - USRCompleteData
struct UsrCompleteData: Codable {
    let data: DataClass?
    let ad: Ad?
}

// MARK: - Ad
struct Ad: Codable {
    let company: String?
    let url: String?
    let text: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
