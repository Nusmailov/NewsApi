//
//  ArticlesViewModel.swift
//  NewsApi
//
//  Created by Nurzhigit Smailov on 7/16/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class ArticlesViewModel {

    func getListNews(success: @escaping ([Articles]) -> (), failure: @escaping (Error) -> Void ) {
        NewsNetworkService.getNewsList(success: { (news) in
            success(news)
        }) { (error) in
            failure(error)
        }
    }
}
