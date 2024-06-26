//
//  FlightLiveActivityView.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 6/25/24.
//

import Foundation
import SwiftUI
import ActivityKit
import WidgetKit

struct FlightLiveActivityView: View {
    let context: ActivityViewContext<FlightAttributes>

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "airplane")
                    .font(.largeTitle)
                    .padding(.trailing, 8)
                VStack(alignment: .leading) {
                    Text("Airline: \(context.attributes.airline)")
                    Text("Flight Number: \(context.state.flightNumber)")
                }
            }
            HStack {
                Image(systemName: "clock")
                    .font(.title)
                    .padding(.trailing, 4)
                VStack(alignment: .leading) {
                    Text("Departure: \(context.state.departureTime, formatter: dateFormatter)")
                    Text("Arrival: \(context.state.arrivalTime, formatter: dateFormatter)")
                }
            }
            Text("Status: \(context.state.status)")
        }
        .padding()
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }
}
