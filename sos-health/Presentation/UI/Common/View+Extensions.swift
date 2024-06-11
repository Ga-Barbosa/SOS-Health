//
//  View+Extension.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 25/11/21.
//

import SwiftUI

extension View {
    func underlineTextField() -> some View {
        padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.primary)
    }
}
