//
//  ContentView.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 6/25/24.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var activityId: String?
    @State private var flightAttributes: FlightAttributes?
    @State private var isFlightStarted = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Start Flight Activity") {
                startFlightActivity()
            }
            .disabled(isFlightStarted)

            if isFlightStarted {
                Button("Update Flight Activity") {
                    guard let activityId = activityId else { return }
                    updateFlightActivity(activityId: activityId)
                }

                Button("End Flight Activity") {
                    guard let activityId = activityId else { return }
                    endFlightActivity(activityId: activityId)
                }
            }
        }
        .padding()
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
            self.activityId = activity.id
            self.isFlightStarted = true
        } catch {
            print("Error requesting live activity: \(error.localizedDescription)")
        }
    }

    func updateFlightActivity(activityId: String) {
        let newStatus = "Delayed"
        let newDepartureTime = Date().addingTimeInterval(2 * 60 * 60)
        let newArrivalTime = Date().addingTimeInterval(7 * 60 * 60)

        Task {
            if let activity = Activity<FlightAttributes>.activities.first(where: { $0.id == activityId }) {
                await activity.update(using: FlightAttributes.ContentState(
                    flightNumber: activity.content.state.flightNumber,
                    departureTime: newDepartureTime,
                    arrivalTime: newArrivalTime,
                    status: newStatus
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
                self.isFlightStarted = false
            }
        }
    }
}


#Preview {
    ContentView()
}


