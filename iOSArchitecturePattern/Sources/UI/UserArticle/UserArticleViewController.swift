//
//  UserArticleViewController.swift
//  iOSArchitecturePattern
//
//  Created by shoki terashita on 2018/03/19.
//  Copyright © 2018年 shokiterasita. All rights reserved.
//

import UIKit

class UserArticleViewController: UIViewController {
    
    private let article: Article
    private let favoriteModel: FavoriteModel
    
    
    init(article: Article, favoriteModel: FavoriteModel) {
        self.article = article
        self.favoriteModel = favoriteModel
        
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
