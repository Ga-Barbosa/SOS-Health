//
//  EmergencyCareDataSource.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 28/11/21.
//

import Foundation

protocol EmergencyCareDataSource {
    func getUnits() async -> [CareUnits]?
}

