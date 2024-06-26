//
//  FlightTrackerWidgetBundle.swift
//  FlightTrackerWidget
//
//  Created by Lyndon Cruz on 6/25/24.
//

import WidgetKit
import SwiftUI
import ActivityKit

@main
struct FlightTrackerWidgetBundle: WidgetBundle {
    var body: some Widget {
        FlightTrackerWidget()
        FlightTrackerLiveActivityWidget()
    }
}



