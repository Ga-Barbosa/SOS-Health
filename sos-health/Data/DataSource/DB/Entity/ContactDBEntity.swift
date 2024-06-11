//
//  ContactDBEntity.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 28/11/21.
//

import Foundation

public struct ContactDBEntity: Codable {

    let uid: String
    let name: String
    let email: String
    let phoneNumber: String
    let notify: Bool

    enum CodingKeys: String, CodingKey {
        case uid
        case name
        case email
        case phoneNumber
        case notify
    }
}
