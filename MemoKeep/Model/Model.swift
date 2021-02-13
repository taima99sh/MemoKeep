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

    let title: String
    let date: Date
    let memos: [Memo]?


    enum CodingKeys: String, CodingKey {
        case title
        case date
        case memos
    }
}

struct Memo: Codable {

    let title: String
    let body: String?
    let date: Date
    let isStarred: Bool = false
    let color: Int = 0


    enum CodingKeys: String, CodingKey {
        case title
        case body
        case date
        case isStarred
        case color
    }
}
