//
//  EmergencyCareRepositoryImpl.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 28/11/21.
//

import Foundation

struct EmergencyCareRepositoryImpl: EmergencyCareRepository {

    var dataSource: EmergencyCareDataSource

    func getUnits() async -> [CareUnits]? {
        return await dataSource.getUnits()
    }
}
