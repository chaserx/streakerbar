//
//  Async.swift
//  Sales App
//
//  Created by Michael on 2/19/15.
//

import Foundation

internal func queueMainThread(block: dispatch_block_t) {
	dispatch_async(dispatch_get_main_queue(), block)
}

internal func queueInteractiveThread(block: dispatch_block_t) {
	_async_qos_do(QOS_CLASS_USER_INTERACTIVE, block)
}

internal func queueUserInitThread(block: dispatch_block_t) {
	_async_qos_do(QOS_CLASS_USER_INITIATED, block)
}

internal func queueUtilityThread(block: dispatch_block_t) {
	_async_qos_do(QOS_CLASS_UTILITY, block)
}

internal func queueBackgroundThread(block: dispatch_block_t) {
	_async_qos_do(QOS_CLASS_BACKGROUND, block)
}

private func _async_qos_do(qos: dispatch_qos_class_t, block: dispatch_block_t) {
	dispatch_async(dispatch_get_global_queue(qos, 0), block)
}

internal func mutexLock<T>(lockObj: AnyObject!, block: ()->T) -> T {
	objc_sync_enter(lockObj)
	let retVal: T = block()
	objc_sync_exit(lockObj)
	return retVal
}

