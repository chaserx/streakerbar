//
//  AppDelegate.swift
//  streakerbar
//
//  Created by Chase Southard on 3/22/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//
//
// NEEDS:
// - func: reads config possibly [github] from ~/.gitconfig
// - func: pulls user contributions from https://github.com/users/:username/contributions
// inspiration: https://github.com/akerl/githubstats/blob/master/lib/githubstats.rb


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon = NSImage(named: "statusIcon")
        icon?.setTemplate(true)
        
        statusItem.image = icon
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func menuClicked(sender: NSMenuItem){
        NSApplication.sharedApplication().terminate(self)
    }
    
}

