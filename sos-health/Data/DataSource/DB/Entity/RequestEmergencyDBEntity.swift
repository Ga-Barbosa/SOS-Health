//
//  RequestEmergencyDBEntity.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 30/11/21.
//

import Foundation

struct RequestEmergencyDBEntity: Codable {

    var uid: String
    var date: String
    var eventLat: Double
    var eventLong: Double
    var eventDesc: String
    var notified: Bool
}

struct ModelRequestEmergency: Hashable {

    var uid: String
    var date: String
    var eventLat: Double
    var eventLong: Double
    var eventDesc: String
    var notified: Bool
}

