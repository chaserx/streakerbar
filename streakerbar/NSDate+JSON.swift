//
//  NSDate+JSON.swift
//  streakerbar
//
//  Created by Michael on 3/24/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//

import Foundation

extension NSDate {

	class func dateWithJSONString(string: String) -> NSDate? {
		return JSONDateFormatter.dateFromString(string)
	}

	var JSONString: String {
		return NSDate.JSONDateFormatter.stringFromDate(self)
	}

	private class var JSONDateFormatter: NSDateFormatter {
		let formatter = NSDateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
		return formatter
	}
}