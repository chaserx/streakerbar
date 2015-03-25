//
//  NSDate+JSON.swift
//  streakerbar
//
//  Created by Michael on 3/24/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//

import Foundation

extension NSDateFormatter {

	class func dateFromJSONString(string: String) -> NSDate? {
		return JSONDateFormatter.dateFromString(string)
	}

	class func JSONStringFromDate(date: NSDate) -> String {
		return JSONDateFormatter.stringFromDate(date)
	}

	private class var JSONDateFormatter: NSDateFormatter {
		let formatter = NSDateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
		return formatter
	}
}