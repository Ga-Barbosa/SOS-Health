//
//  AuthenticationService.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 14/11/21.
//

import Firebase

class AuthenticationService: ObservableObject {
    enum Status: Equatable {
        case authenticated
        case unauthenticated
    }

    static var shared = AuthenticationService()

    @Published var status: Status

    init() {
        status = Preferences.shared.userLoginComplete ? .authenticated : .unauthenticated
    }
}
