//
//  NewsNetworkService.swift
//  NewsApi
//
//  Created by Nurzhigit Smailov on 7/15/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NewsNetworkService {
    
    static func getNewsList(success: @escaping ([Articles]) -> Void, failure: @escaping (Error) -> Void) {
        let url = URL.init(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=278c4eedba494ae38c56bf770dc7bede")
        let params = [String: Any]()
        Alamofire.request(url!, parameters: params, headers: nil)
            .responseJSON { response in
                switch response.result {
                    case .success(let val):
                        let info = JSON(val)["articles"].arrayValue
                        var res = [Articles]()
                        for i in info {
                            res.append(Articles.init(json: i))
                        }
                        success(res)
                    case .failure(let error):
                        failure(error)
                }
        }
    }
}
