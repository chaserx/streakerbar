//
//  AppDelegate.swift
//  streakerbar
//
//  Created by Chase Southard on 3/22/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//  https://github.com/chaserx/streakerbar
//
// NEEDS:
// - func: updates statusItem.title on interval using NSTimer or GCD's dispatch_after
// Inspiration: https://github.com/akerl/githubstats/blob/master/lib/githubstats.rb


import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var usernameMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(30.0) // use -1 for variable length but it seems to get cut off on the right.

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon = NSImage(named: "statusIcon")
        icon?.setTemplate(true)
        
        statusItem.image = icon
        statusItem.menu = statusMenu
        updateTitle("?")
//        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("randShit"), userInfo: nil, repeats: true)
        if let username = getGithubUsernameFromGitconfig() {
            updateStatusForUser(username)
        } else if let username = promptForUsername() {
            updateStatusForUser(username)
        } else {
            // :( 
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func quitApp(sender: NSMenuItem){
        NSApplication.sharedApplication().terminate(self)
    }
    
    @IBAction func openUserProfileOnGithub(sender: NSMenuItem){
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://github.com/\(usernameMenuItem.title)")!)
    }

    func updateStatusForUser(username: String) {
        let interactor = GHInteractor(username: username)
        let events = interactor.todaysEventsOfType(GHEventType.Push)
        updateUsernameMenuItem(username)
        updateTitle("\(events.count)")
    }

    func updateTitle(title: String) {
        statusItem.title = title
    }
    
    func updateUsernameMenuItem(username: String) {
        usernameMenuItem.title = username
    }
    
    func randShit() {
        updateTitle(String(arc4random_uniform(10)))
    }
    
    func getGithubUsernameFromGitconfig() -> String? {
        let path = "~/.gitconfig"
        let location = path.stringByExpandingTildeInPath
        let data: NSData? = NSData(contentsOfFile: location)
        
        if let fileData = data {
            let content = NSString(data: fileData, encoding:NSUTF8StringEncoding) as! String
            let matches = listMatches("user = \\w+", inString: content)
            // if let is kinda weird but otherwise get Optional("chaserx")
            if let username = replaceMatches("user = ", inString: matches[0], withString: "") {
                // println(username)
                return username
            }
        }
        return nil
    }

    func promptForUsername() -> String? {
        let alert = NSAlert()
        alert.messageText = "Enter your GitHub username."
        alert.addButtonWithTitle("Save")
        alert.addButtonWithTitle("Cancel")

        let field = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        alert.accessoryView = field

        var username: String?
        switch alert.runModal() {
        case NSAlertDefaultReturn:
            username = field.stringValue
            if username == "" {
                username = nil
            }
        default:
            username = nil
        }
        return username
    }
    
    func listMatches(pattern: String, inString string: String) -> [String] {
        let regex = NSRegularExpression(pattern: pattern, options: .allZeros, error: nil)
        let range = NSMakeRange(0, count(string))
        let matches = regex?.matchesInString(string, options: .allZeros, range: range) as! [NSTextCheckingResult]
        
        return matches.map {
            let range = $0.range
            return (string as NSString).substringWithRange(range)
        }
    }
    
    func replaceMatches(pattern: String, inString string: String, withString replacementString: String) -> String? {
        let regex = NSRegularExpression(pattern: pattern, options: .allZeros, error: nil)
        let range = NSMakeRange(0, count(string))
        
        return regex?.stringByReplacingMatchesInString(string, options: .allZeros, range: range, withTemplate: replacementString)
    }
    
}

