//
//  GetEmergencyCareUnits.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 30/11/21.
//

import Foundation

protocol GetEmergencyCareUnits {
    func execute() async -> [CareUnits]?
}

struct GetEmergencyCareUnitsUseCase: GetEmergencyCareUnits {

    var repo: EmergencyCareRepository

    func execute() async -> [CareUnits]? {
        return await repo.getUnits()
    }
}
