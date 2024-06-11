//
//  DBServiceError.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 17/11/21.
//

import Foundation

enum DBServiceError: Error {
    case userNotFound, onboardNotCompleted, decodingError

    var title: String {
        switch self {
        default:
            return "System unavailable"
        }
    }

    var description: String {
        switch self {
        default:
            return "Sorry but our services are currently unavailable"
        }
    }
}
