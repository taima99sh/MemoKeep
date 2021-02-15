//
//  TMemo+CoreDataProperties.swift
//  MemoKeep
//
//  Created by taima on 2/15/21.
//  Copyright © 2021 mac air. All rights reserved.
//
//

import Foundation
import CoreData


extension TMemo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TMemo> {
        return NSFetchRequest<TMemo>(entityName: "TMemo")
    }
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var body: String?
    @NSManaged public var date: Date
    @NSManaged public var memoBookId: String
    @NSManaged public var isStarred: Bool
    @NSManaged public var memoBook: TMemoBook?
}
