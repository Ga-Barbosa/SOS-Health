//
//  GetContacts.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 28/11/21.
//

import Foundation

protocol GetContacts {
    func execute(uid: String) async -> [Contact]?
}

struct GetContactsUseCase: GetContacts {

    var repo: ContactRepository

    func execute(uid: String) async -> [Contact]? {
        return await repo.getContacts(uid: uid)
    }
}

