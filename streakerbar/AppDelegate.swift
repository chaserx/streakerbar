//
//  AppDelegate.swift
//  streakerbar
//
//  Created by Chase Southard on 3/22/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//
//
// NEEDS:
// - func: reads config possibly [github] from ~/.gitconfig or from NSUserDefaults
// - func: pulls user contributions from https://github.com/users/:username/contributions
// - func: parse HTML/XML/SVG data from the contributions svg; grab data for today; update display
// - func: updates statusItem.title on interval using NSTimer or GCD's dispatch_after
// inspiration: https://github.com/akerl/githubstats/blob/master/lib/githubstats.rb



import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(30.0) // use -1 for variable length but it seems to get cut off on the right.

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon = NSImage(named: "statusIcon")
        icon?.setTemplate(true)
        
        statusItem.image = icon
        statusItem.menu = statusMenu
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("randShit"), userInfo: nil, repeats: true)
        readGitconfigFile()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func menuClicked(sender: NSMenuItem){
        NSApplication.sharedApplication().terminate(self)
    }
    
    func updateTitle(title: String) {
        statusItem.title = title
    }
    
    func randShit() {
        updateTitle(String(arc4random_uniform(10)))
    }
    
    func readGitconfigFile(){
        let path = "~/.gitconfig"
        let location = path.stringByExpandingTildeInPath
        let data: NSData? = NSData(contentsOfFile: location)
        
        if let fileData = data {
            let content = NSString(data: fileData, encoding:NSUTF8StringEncoding) as String
            println(content) // great, now how to grab github username?
        }
    }
    
}

