//
//  RequestEmergencyRepository.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 30/11/21.
//

import Foundation

protocol RequestEmergencyRepository {
    func requestEvent(event: EmergencyAction) async -> Bool
}
