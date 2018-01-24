//
//  TimePeriodProtocol+Clamped.swift
//  CalendarKit
//
//  Created by Florian Fittschen on 24.01.18.
//

import DateToolsSwift

extension TimePeriodProtocol {
    func clampedDuration(from range: PartialRangeFrom<TimeInterval>) -> TimeInterval {
        if duration < range.lowerBound {
            return range.lowerBound
        } else {
            return duration
        }
    }

    func normalized(to minDuration: TimeInterval) -> TimePeriodProtocol {
        guard let beginning = beginning,
            let end = end,
            duration < minDuration else {
                return self
        }

        let diff = Int(minDuration - duration)
        let newEnd = end.add(diff.seconds)

        return TimePeriod(beginning: beginning, end: newEnd)
    }
}
