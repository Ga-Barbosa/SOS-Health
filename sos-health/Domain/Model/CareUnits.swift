//
//  CareUnits.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 28/11/21.
//

import Foundation
import Firebase

struct CareUnits: Hashable {

    var name: String
    var address: String
    var city: String
    var uf: String
    var urlImage: String
    var zipCode: String
    var coords: Firebase.GeoPoint
}
