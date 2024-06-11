//
//  ContactDataSource.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 28/11/21.
//

import Foundation

protocol ContactDataSource {
    func createContact(uid: String, contact: Contact) async -> Bool
    func getContacts(uid: String) async -> [Contact]?
}
