//
//  Model.swift
//  MemoKeep
//
//  Created by taima on 2/13/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import Foundation

struct User: Codable {

    let name: String
    let email: String
    let memoBooks: [MemoBook]?


    enum CodingKeys: String, CodingKey {
        case name
        case email
        case memoBooks
    }

}

public struct MemoBook: Codable {
    var id: String?
    let title: String
    let date: Date
    let memos: [Memo]?

    enum CodingKeys: String, CodingKey {
        case title
        case date
        case memos
        case id
    }
    
    init(_ obj : TMemoBook){
        self.id = obj.id
        self.title = obj.title
        self.date = obj.date
        self.memos = (obj.memo?.allObjects as? [TMemo] ?? []).map({Memo($0)})
    }
}

struct Memo: Codable {
    
    var id: String?
    let title: String
    let body: String?
    let date: Date
    let isStarred: Bool?
    let color: Int

    enum CodingKeys: String, CodingKey {
        case title
        case body
        case date
        case isStarred
        case color
        case id
    }
    
    init(_ obj : TMemo) {
        //self.id = obj.id
    }
}
