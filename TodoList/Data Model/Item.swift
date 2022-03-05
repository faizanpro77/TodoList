//
//  Item.swift
//  TodoList
//
//  Created by Yashom on 05/03/22.
//

import Foundation

class Item: Codable {   //Encodable, Decodable
    var title: String = ""
    var done : Bool = false
}
