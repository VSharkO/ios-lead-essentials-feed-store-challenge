//
//  ManagedCache.swift
//  FeedStoreChallenge
//
//  Created by Valentin Šarić on 24.08.2021..
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedCache)
final class ManagedCache: NSManagedObject {
	@NSManaged var timestamp: Date
	@NSManaged var feed: NSOrderedSet

	static func getNewUniqueInstance(context: NSManagedObjectContext) throws -> ManagedCache {
		try find(in: context).map(context.delete)
		return ManagedCache(context: context)
	}

	static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
		guard let name = entity().name else { return nil }
		let request = NSFetchRequest<ManagedCache>(entityName: name)
		request.returnsObjectsAsFaults = false
		return try context.fetch(request).first
	}
}
