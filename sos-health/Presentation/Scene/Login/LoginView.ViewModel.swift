//
//  LoginView.ViewModel.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 14/11/21.
//

import Foundation

extension LoginView {

    class ViewModel: ObservableObject {

        func login(email: String, password: String) {
            print("login", "email:", email, "password:", password)
        }
    }
}
