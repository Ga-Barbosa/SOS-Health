//
//  UserDBEntity.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 15/11/21.
//

import Foundation

struct UserDBEntity: Codable {

    var fullName: String?
    let phoneNumber: String?
    let address: AddressDBEntity?
    let onboardCompleted: Bool?
}

extension UserDBEntity {

    init() {
        fullName = nil
        phoneNumber = nil
        address = nil
        onboardCompleted = false
    }
}
