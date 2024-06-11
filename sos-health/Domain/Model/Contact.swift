//
//  Contact.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 28/11/21.
//

import Foundation

struct Contact: Codable, Hashable {

    var name: String
    var email: String
    var phoneNumber: String
    var notify: Bool
}

extension Contact {
    init() {
        self.name = ""
        self.email = ""
        self.phoneNumber = ""
        self.notify = false
    }
}
