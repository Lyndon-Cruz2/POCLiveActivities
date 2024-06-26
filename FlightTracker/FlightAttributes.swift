//
//  FlightAttributes.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 6/25/24.
//

import Foundation
import ActivityKit

struct FlightAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var flightNumber: String
        var departureTime: Date
        var arrivalTime: Date
        var status: String
    }

    var airline: String
}
