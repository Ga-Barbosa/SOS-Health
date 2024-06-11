//
//  AuthenticatedCoordinator+Factory.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 27/11/21.
//

import Stinsen
import SwiftUI

extension AuthenticatedCoordinator {

    func makeHome() -> HomeCoordinator {
        return HomeCoordinator()
    }

    @ViewBuilder func makeHomeTab(isActive: Bool) -> some View {
        Image(systemName: "house" + (isActive ? ".fill" : ""))
        Text("Home")
    }

    func makeHistory() -> HistoryCoordinator {
        return HistoryCoordinator()
    }

    @ViewBuilder func makeHistoryTab(isActive: Bool) -> some View {
        Image(systemName: "clock.arrow.circlepath")
        Text("Histórico")
    }

    func makeProfile() -> NavigationViewCoordinator<ProfileCoordinator> {
        return NavigationViewCoordinator(ProfileCoordinator())
    }

    @ViewBuilder func makeProfileTab(isActive: Bool) -> some View {
        Image(systemName: "person.fill")
        Text("Perfil")
    }
}
