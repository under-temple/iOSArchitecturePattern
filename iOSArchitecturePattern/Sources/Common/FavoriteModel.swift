//
//  FavoriteModel.swift
//  iOSArchitecturePattern
//
//  Created by shoki terashita on 2018/03/19.
//  Copyright © 2018年 shokiterasita. All rights reserved.
//

import UIKit

@objc protocol FavoriteModelDelegate: class {
    @objc optional func favoriteDidChange()
}


final class FavoriteModel {
    
    
    private(set) var favorites: [Article] = [] {
        didSet {
            delegate?.favoriteDidChange?()
        }
    }
    weak var delegate: FavoriteModelDelegate?
    
    func addFavorite(_ article: Article) {

    }
    
    func removeFavorite(_ article: Article) {
    
        
    }
    

}



