//
//  FlightTrackerWidgetLiveActivity.swift
//  FlightTrackerWidget
//
//  Created by Lyndon Cruz on 6/25/24.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct FlightTrackerLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightAttributes.self) { context in
            FlightLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "airplane")
                        .font(.title)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Status: \(context.state.status)")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Image(systemName: "clock")
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text("Departure: \(context.state.departureTime, formatter: dateFormatter)")
                            Text("Arrival: \(context.state.arrivalTime, formatter: dateFormatter)")
                        }
                    }
                }
            } compactLeading: {
                Image(systemName: "airplane")
                    .font(.title)
            } compactTrailing: {
                Image(systemName: "clock")
                    .font(.title)
            } minimal: {
                Image(systemName: "airplane")
                    .font(.title)
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }
}

