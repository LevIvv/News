//
//  Model.swift
//  News
//
//  Created by Лев Ивлев on 23.04.2023.
//

import Foundation
struct Article {
    var title:String
    var urlToImage:String
    var url:String
    var description:String
    var publishedAt:String
    var source:String
    

    init(dictionary: Dictionary<String, Any>) {
        title = dictionary["title"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
        source = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""])["name"] as? String ?? ""

    }
}
