//
//  TUser+CoreDataProperties.swift
//  MemoKeep
//
//  Created by taima on 2/15/21.
//  Copyright © 2021 mac air. All rights reserved.
//
//

import Foundation
import CoreData


extension TUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TUser> {
        return NSFetchRequest<TUser>(entityName: "TUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var memoBook: NSSet?

}

// MARK: Generated accessors for memoBook
extension TUser {

    @objc(addMemoBookObject:)
    @NSManaged public func addToMemoBook(_ value: TMemoBook)

    @objc(removeMemoBookObject:)
    @NSManaged public func removeFromMemoBook(_ value: TMemoBook)

    @objc(addMemoBook:)
    @NSManaged public func addToMemoBook(_ values: NSSet)

    @objc(removeMemoBook:)
    @NSManaged public func removeFromMemoBook(_ values: NSSet)

}
