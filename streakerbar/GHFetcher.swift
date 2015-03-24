//
//  GHFetcher.swift
//  streakerbar
//
//  Created by Michael on 3/24/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//

import Foundation

struct GHFetcher {

	static func eventsEndpointForUser(username: String) -> NSURL {
		return NSURL(string: "https://api.github.com/users/\(username)/events")!
	}

	static func fetchEventsForUser(username: String) -> Fetch {
		let url = eventsEndpointForUser(username)
		return Fetch(endpoint: url)
	}
}


class Fetch {

	let endpoint: NSURL

	init(endpoint: NSURL) {
		self.endpoint = endpoint
	}

	enum Status {
		case Pending
		case Success
		case Failure
	}

	var status: Status = .Pending
	var response: NSData?
	var error: NSError?

	typealias Succeeder = (NSData) -> ()
	typealias Failer = (NSError) -> ()

	private var successHandler: Succeeder?
	private var failureHandler: Failer?

	func onSuccess(handler: Succeeder) -> Fetch {
		if status == .Success {
			handler(response!)
		} else {
			successHandler = handler
		}
		return self
	}

	func onFailure(handler: Failer) -> Fetch {
		if status == .Failure {
			handler(error!)
		} else {
			failureHandler = handler
		}
		return self
	}

	func start() -> Fetch {
		if let response = NSData(contentsOfURL: self.endpoint, options: .DataReadingMapped, error: &self.error) {
			self.status = .Success
			self.response = response
			self.successHandler?(response)
		} else if let error = self.error {
			self.status = .Failure
			self.failureHandler?(error)
		}
		return self
	}

	func startAsync() -> Fetch {
		queueUserInitThread {
			let _ = self.start()
		}
		return self
	}
}
