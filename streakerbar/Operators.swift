//
//  Operators.swift
//  Sales App
//
//  Created by Michael on 2/19/15.
//

import Foundation

// Precedence: lower than casts, higher than bool comparators
infix operator || {associativity right precedence 131}
func || <T> (optional: T?, fallback: T) -> T {
	if let value = optional {
		return value
	} else {
		return fallback
	}
}
