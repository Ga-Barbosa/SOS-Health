//
//  EmergencyCareRepository.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 28/11/21.
//

import Foundation

protocol EmergencyCareRepository {
    func getUnits() async -> [CareUnits]?
}

