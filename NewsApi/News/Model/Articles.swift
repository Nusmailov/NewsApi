//
//  Articles.swift
//  NewsApi
//
//  Created by Nurzhigit Smailov on 7/15/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation
import SwiftyJSON

class Articles {
    
    var source: Source!
    var author: String
    var title: String
    var description: String
    var urlToImage: String?
    var url: String
    var publishedAt: String
    
    init(json: JSON) {
        source = Source.init(json: json["source"])
        author = json["author"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        urlToImage = json["urlToImage"].stringValue
        url = json["url"].stringValue
        publishedAt = json["publishedAt"].stringValue
    }
    
    init(author: String, title: String, description: String, urlToImage: String, url: String, publishedAt: String){
        self.author = author
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.url = url
        self.publishedAt = publishedAt
    }
}

class Source {
    var id: String!
    var name: String!
    
    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
    }
}
