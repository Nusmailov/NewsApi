//
//  Filter.swift
//  NewsApi
//
//  Created by Nurzhigit Smailov on 7/16/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation

enum Filter {
    case ascendingOrder
    case descendingOrder
    case search(String)
    case none
}

