//
//  MockData.swift
//  iOS TaskTests
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation

struct MockData {
    static let postCombinedDictionary: [String: Any] = [
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
        "user": userDictionary
    ]
    
    static let postDictionary: [String: Any] = [
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    ]
    
    static let userDictionary: [String: Any] = [
        "id": 1,
        "name": "Leanne Graham",
        "username": "Bret",
        "email": "Sincere@april.biz",
        "address": [
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": [
                "lat": "-37.3159",
                "lng": "81.1496"
            ]
        ],
        "phone": "1-770-736-8031 x56442",
        "website": "hildegard.org",
        "company": [
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
        ]
    ]
}
