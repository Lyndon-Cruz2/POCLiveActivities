//
//  FlightTrackerWidget.swift
//  FlightTrackerWidget
//
//  Created by Lyndon Cruz on 6/25/24.
//

import WidgetKit
import SwiftUI

struct FlightTrackerWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.yourcompany.FlightTrackerWidget",
            provider: Provider()
        ) { entry in
            FlightTrackerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Flight Tracker Widget")
        .description("Track your flights with up-to-date status.")
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct FlightTrackerWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct PlaceholderView: View {
    var body: some View {
        Text("Loading...")
    }
}

