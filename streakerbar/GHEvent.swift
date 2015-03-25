//
//  GHEvent.swift
//  streakerbar
//
//  Created by Michael on 3/23/15.
//  Copyright (c) 2015 Chase Southard. All rights reserved.
//

import Foundation


struct GHEvent {
	var id: String
	var type: GHEventType
	var createdDate: NSDate
	var repoName: String
	var repoURL: NSURL
}


struct GHEventFactory {

	typealias ParsedJSON = [[String: AnyObject]]

	static func eventsFromJSONResponse(data: NSData) -> [GHEvent] {
		if let parsedJSON = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: nil) as? ParsedJSON {
			return eventsFromJSONObjects(parsedJSON)
		}
		return [GHEvent]()
	}

	static func eventsFromJSONObjects(json: ParsedJSON) -> [GHEvent] {
		var events = [GHEvent]()
		for object in json {
			if let id = object["id"] as? String {

				let typeString = object["type"] as? String || "UnknownEvent"
				if let type = GHEventType(rawValue: typeString) {

					if let createdDateString = object["created_at"] as? String {
						if let createdDate = NSDateFormatter.dateFromJSONString(createdDateString) {
							
							let repo = object["repo"] as? [String: AnyObject]
							let repoName = repo?["name"] as? String || ""
							let repoURLString = repo?["url"] as? String || ""
							let repoURL = NSURL(string: repoURLString)!

							let event = GHEvent(id: id, type: type, createdDate: createdDate, repoName: repoName, repoURL: repoURL)
							events.append(event)
						}
					}
				}
			}
		}
		return events
	}
}


enum GHEventType: String {
	case CommitComment = "CommitCommentEvent"
	case Create = "CreateEvent"
	case Delete = "DeleteEvent"
	case Deployment = "DeploymentEvent"
	case DeploymentStatus = "DeploymentStatusEvent"
	case Download = "DownloadEvent"
	case Follow = "FollowEvent"
	case Fork = "ForkEvent"
	case ForkApply = "ForkApplyEvent"
	case Gist = "GistEvent"
	case Gollum = "GollumEvent"
	case IssueComment = "IssueCommentEvent"
	case Issues = "IssuesEvent"
	case Member = "MemberEvent"
	case Membership = "MembershipEvent"
	case PageBuild = "PageBuildEvent"
	case Public = "PublicEvent"
	case PullRequest = "PullRequestEvent"
	case PullRequestReviewComment = "PullRequestReviewCommentEvent"
	case Push = "PushEvent"
	case Release = "ReleaseEvent"
	case Repository = "RepositoryEvent"
	case Status = "StatusEvent"
	case TeamAdd = "TeamAddEvent"
	case Watch = "WatchEvent"
}
