//
//  RequestEmergencyDataSource.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 30/11/21.
//

import Foundation

protocol RequestEmergencyDataSource {
    func requestedEvents() async -> [RequestEmergencyDBEntity]?
    func requestEvent(event: EmergencyAction) async -> Bool
}
