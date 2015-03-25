//
//  GHInteractor.swift
//  streakerbar
//
//  Created by Michael on 3/24/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//

import Foundation

struct GHInteractor {

	var username: String

	func allEvents() -> [GHEvent] {
		var events = [GHEvent]()
		GHFetcher.fetchEventsForUser(username).onSuccess { eventData in
			events = GHEventFactory.eventsFromJSONResponse(eventData)
			}.onFailure { error in
				println(error)
			}.start()
		return events
	}

	func todaysEvents() -> [GHEvent] {
		return eventsForDate(NSDate())
	}

	func eventsForDate(date: NSDate) -> [GHEvent] {
		let events = allEvents()
		return events.filter { datesAreOnSameDay(date, $0.createdDate) }
	}
}


private func datesAreOnSameDay(first: NSDate, second: NSDate) -> Bool {
	let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
	let units: NSCalendarUnit = (.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit)
	let firstDay = calendar.components(units, fromDate: first)
	let secondDay = calendar.components(units, fromDate: second)
	return firstDay.year == secondDay.year && firstDay.month == secondDay.month && firstDay.day == secondDay.day
}
