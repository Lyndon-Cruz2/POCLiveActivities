//
//  ContentView.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 6/25/24.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Start Flight Activity") {
                startFlightActivity()
            }
            // Add more UI elements to update and end activity as needed
        }
        .padding()
    }
}


func startFlightActivity() {
    let attributes = FlightAttributes(airline: "Airline Name")
    let initialContentState = FlightAttributes.ContentState(
        flightNumber: "AB123",
        departureTime: Date().addingTimeInterval(60 * 60),
        arrivalTime: Date().addingTimeInterval(5 * 60 * 60),
        status: "On Time"
    )

    do {
        let activity = try Activity<FlightAttributes>.request(
            attributes: attributes,
            contentState: initialContentState,
            pushType: nil
        )
        print("Requested a flight live activity with id: \(activity.id)")
    } catch {
        print("Error requesting live activity: \(error.localizedDescription)")
    }
}

func updateFlightActivity(activityId: String, status: String, departureTime: Date, arrivalTime: Date) {
    Task {
        if let activity = Activity<FlightAttributes>.activities.first(where: { $0.id == activityId }) {
            await activity.update(using: FlightAttributes.ContentState(
                flightNumber: activity.content.state.flightNumber,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
                status: status
            ))
        }
    }
}

func endFlightActivity(activityId: String) {
    Task {
        if let activity = Activity<FlightAttributes>.activities.first(where: { $0.id == activityId }) {
            await activity.update(using: FlightAttributes.ContentState(
                flightNumber: activity.content.state.flightNumber,
                departureTime: activity.content.state.departureTime,
                arrivalTime: activity.content.state.arrivalTime,
                status: "Arrived"
            ))
        }
    }
}


#Preview {
    ContentView()
}


