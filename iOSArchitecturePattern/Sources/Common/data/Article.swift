//
//  Article.swift
//  iOSArchitecturePattern
//
//  Created by shoki terashita on 2018/03/19.
//  Copyright © 2018年 shokiterasita. All rights reserved.
//

import UIKit

public struct Article {
    
    // Qiitaの記事モデル
    public let name: String
    
    public let url: URL

    public let title: String

}


public struct PageInfo {
    
    public let hasNextPage: Bool
    
    public let endCursor: String?
    
    public let hasPreviousPage: Bool
    
    public let startCursor: String?
}
