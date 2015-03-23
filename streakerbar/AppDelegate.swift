//
//  AppDelegate.swift
//  streakerbar
//
//  Created by Chase Southard on 3/22/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func menuClicked(sender: NSMenuItem){
        // Insert code here to quit app
    }

}

