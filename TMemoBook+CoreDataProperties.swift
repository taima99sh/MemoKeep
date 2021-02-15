//
//  TMemoBook+CoreDataProperties.swift
//  MemoKeep
//
//  Created by taima on 2/15/21.
//  Copyright © 2021 mac air. All rights reserved.
//
//

import Foundation
import CoreData


extension TMemoBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TMemoBook> {
        return NSFetchRequest<TMemoBook>(entityName: "TMemoBook")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var userId: String?
    @NSManaged public var ofUser: TUser
    @NSManaged public var memo: NSSet?

}

// MARK: Generated accessors for memo
extension TMemoBook {

    @objc(addMemoObject:)
    @NSManaged public func addToMemo(_ value: TMemo)

    @objc(removeMemoObject:)
    @NSManaged public func removeFromMemo(_ value: TMemo)

    @objc(addMemo:)
    @NSManaged public func addToMemo(_ values: NSSet)

    @objc(removeMemo:)
    @NSManaged public func removeFromMemo(_ values: NSSet)

}
